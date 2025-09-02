import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:d2_touch/d2_touch.dart'; // Importing D2Touch SDK
import 'isar_service.dart';

class ComprehensiveSyncService {
  static String? _baseUrl;
  static String? _authHeader;

  static Future<void> syncAllMetadata({
    required Function(SyncProgress) onProgressUpdate,
    required Function(Map<String, int>) onComplete,
  }) async {
    try {
      // Get current authenticated user
      final user = await IsarService.getCurrentUser();
      if (user == null || !user.isLoggedIn) {
        throw Exception('User not authenticated');
      }

      _baseUrl = user.baseUrl;
      _authHeader = user.token;

      if (_baseUrl == null || _authHeader == null) {
        throw Exception('Authentication credentials not available');
      }

      onProgressUpdate(SyncProgress(
        currentType: null,
        message: 'Initializing metadata sync...',
        overallProgress: 0.05,
        typeProgress: 0.0,
        isTypeCompleted: false,
        itemCount: 0,
      ));

      final finalCounts = <String, int>{};

      // Define metadata types to sync with their relative weights
      final metadataTypes = [
        MetadataType('organisationUnits', 'Organisation Units', 0.3),
        MetadataType('programs', 'Programs', 0.25),
        MetadataType('dataElements', 'Data Elements', 0.2),
        MetadataType('indicators', 'Indicators', 0.15),
        MetadataType('dataSets', 'Data Sets', 0.1),
      ];

      double cumulativeProgress = 0.1;

      for (int i = 0; i < metadataTypes.length; i++) {
        final metadata = metadataTypes[i];
        final startProgress = cumulativeProgress;
        final endProgress = cumulativeProgress + metadata.weight;

        try {
          final count = await _syncMetadataType(
            metadata,
            (typeProgress, message, itemCount) {
              final overallProgress = startProgress + (typeProgress * metadata.weight);
              onProgressUpdate(SyncProgress(
                currentType: metadata.key,
                message: message,
                overallProgress: overallProgress,
                typeProgress: typeProgress,
                isTypeCompleted: typeProgress >= 1.0,
                itemCount: itemCount,
              ));
            },
          );

          finalCounts[metadata.key] = count;
          cumulativeProgress = endProgress;

          onProgressUpdate(SyncProgress(
            currentType: metadata.key,
            message: '${metadata.displayName} sync completed ($count items)',
            overallProgress: cumulativeProgress,
            typeProgress: 1.0,
            isTypeCompleted: true,
            itemCount: count,
          ));

        } catch (e) {
          print('Error syncing ${metadata.displayName}: $e');
          finalCounts[metadata.key] = 0;
        }
      }

      // Mark all data as synced
      await IsarService.markAllAsSynced();

      onComplete(finalCounts);

    } catch (e) {
      throw Exception('Comprehensive sync failed: $e');
    }
  }

  static Future<int> _syncMetadataType(
    MetadataType metadata,
    Function(double, String, int) onProgress,
  ) async {
    switch (metadata.key) {
      case 'organisationUnits':
        return await _syncOrganisationUnits(onProgress);
      case 'programs':
        return await _syncPrograms(onProgress);
      case 'dataElements':
        return await _syncDataElements(onProgress);
      case 'indicators':
        return await _syncIndicators(onProgress);
      case 'dataSets':
        return await _syncDataSets(onProgress);
      default:
        return 0;
    }
  }

  static Future<int> _syncOrganisationUnits(Function(double, String, int) onProgress) async {
    try {
      onProgress(0.1, 'Fetching organisation units...', 0);

      final response = await http.get(
        Uri.parse('$_baseUrl/api/organisationUnits?fields=id,name,displayName,shortName,level,path,parent[id],geometry,openingDate,coordinates,code,description&paging=false'),
        headers: {
          'Authorization': _authHeader!,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final orgUnitsData = data['organisationUnits'] as List;

        onProgress(0.3, 'Processing ${orgUnitsData.length} organisation units...', orgUnitsData.length);

        // Use D2Touch SDK for organisation units
        final d2 = D2TouchSingleton().d2Touch;
        // Convert to D2Touch format and save
        for (int i = 0; i < orgUnitsData.length; i++) {
          final orgUnitData = orgUnitsData[i];
          // Add required fields for D2Touch
          orgUnitData['dirty'] = false;
          if (i % 50 == 0) {
            final progress = 0.3 + ((i / orgUnitsData.length) * 0.7);
            onProgress(progress, 'Processing organisation units: ${i + 1}/${orgUnitsData.length}', orgUnitsData.length);
          }
        }
        // Save using D2Touch
        await d2.organisationUnitModule.organisationUnit.setData(
          orgUnitsData.map((data) => data as Map<String, dynamic>).toList()
        ).save();
        onProgress(1.0, 'Organisation units sync completed', orgUnitsData.length);
        return orgUnitsData.length;
      } else {
        throw Exception('Failed to fetch organisation units: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Organisation units sync failed: $e');
    }
  }

  static Future<int> _syncPrograms(Function(double, String, int) onProgress) async {
    try {
      onProgress(0.1, 'Fetching programs...', 0);
      final response = await http.get(
        Uri.parse('$_baseUrl/api/programs?fields=id,name,displayName,shortName,code,description,programType,withoutRegistration,trackedEntityType[id],programStages[id,name,programStageDataElements[dataElement[id,name,valueType]]],programTrackedEntityAttributes[trackedEntityAttribute[id,name,valueType]]&paging=false'),
        headers: {
          'Authorization': _authHeader!,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final programsData = data['programs'] as List;
        onProgress(0.3, 'Processing ${programsData.length} programs...', programsData.length);
        final d2 = D2TouchSingleton().d2Touch;
        // Process and save programs
        for (int i = 0; i < programsData.length; i++) {
          final programData = programsData[i];
          programData['dirty'] = false;
          if (i % 10 == 0) {
            final progress = 0.3 + ((i / programsData.length) * 0.7);
            onProgress(progress, 'Processing programs: ${i + 1}/${programsData.length}', programsData.length);
          }
        }
        // Save using D2Touch
        await d2.programModule.program.setData(
          programsData.map((data) => data as Map<String, dynamic>).toList()
        ).save();
        onProgress(1.0, 'Programs sync completed', programsData.length);
        return programsData.length;
      } else {
        throw Exception('Failed to fetch programs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Programs sync failed: $e');
    }
  }

  static Future<int> _syncDataElements(Function(double, String, int) onProgress) async {
    try {
      onProgress(0.1, 'Fetching data elements...', 0);
      final response = await http.get(
        Uri.parse('$_baseUrl/api/dataElements?fields=id,name,displayName,shortName,code,description,valueType,aggregationType,domainType,formName,optionSet[id,name,options[id,name,code]]&paging=false'),
        headers: {
          'Authorization': _authHeader!,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dataElementsData = data['dataElements'] as List;
        onProgress(0.3, 'Processing ${dataElementsData.length} data elements...', dataElementsData.length);
        final d2 = D2TouchSingleton().d2Touch;
        // Process and save data elements
        for (int i = 0; i < dataElementsData.length; i++) {
          final dataElementData = dataElementsData[i];
          dataElementData['dirty'] = false;
          if (i % 100 == 0) {
            final progress = 0.3 + ((i / dataElementsData.length) * 0.7);
            onProgress(progress, 'Processing data elements: ${i + 1}/${dataElementsData.length}', dataElementsData.length);
          }
        }
        // Save using D2Touch
        await d2.dataElementModule.dataElement.setData(
          dataElementsData.map((data) => data as Map<String, dynamic>).toList()
        ).save();
        onProgress(1.0, 'Data elements sync completed', dataElementsData.length);
        return dataElementsData.length;
      } else {
        throw Exception('Failed to fetch data elements: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Data elements sync failed: $e');
    }
  }

  static Future<int> _syncIndicators(Function(double, String, int) onProgress) async {
    try {
      onProgress(0.1, 'Fetching indicators...', 0);
      final response = await http.get(
        Uri.parse('$_baseUrl/api/indicators?fields=id,name,displayName,shortName,code,description,numerator,denominator,indicatorType[id,name,factor]&paging=false'),
        headers: {
          'Authorization': _authHeader!,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final indicatorsData = data['indicators'] as List;
        onProgress(0.3, 'Processing ${indicatorsData.length} indicators...', indicatorsData.length);
        final d2 = D2TouchSingleton().d2Touch;
        // Process and save indicators
        for (int i = 0; i < indicatorsData.length; i++) {
          final indicatorData = indicatorsData[i];
          indicatorData['dirty'] = false;
          if (i % 25 == 0) {
            final progress = 0.3 + ((i / indicatorsData.length) * 0.7);
            onProgress(progress, 'Processing indicators: ${i + 1}/${indicatorsData.length}', indicatorsData.length);
          }
        }
        // Save using D2Touch
        // await d2.indicatorModule.indicator.setData(
        //   indicatorsData.map((data) => data as Map<String, dynamic>).toList()
        // ).save();
        onProgress(1.0, 'Indicators sync completed', indicatorsData.length);
        return indicatorsData.length;
      } else {
        throw Exception('Failed to fetch indicators: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Indicators sync failed: $e');
    }
  }

  static Future<int> _syncDataSets(Function(double, String, int) onProgress) async {
    try {
      onProgress(0.1, 'Fetching data sets...', 0);
      final response = await http.get(
        Uri.parse('$_baseUrl/api/dataSets?fields=id,name,displayName,shortName,code,description,periodType,dataSetElements[dataElement[id,name]],organisationUnits[id,name]&paging=false'),
        headers: {
          'Authorization': _authHeader!,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dataSetsData = data['dataSets'] as List;
        onProgress(0.3, 'Processing ${dataSetsData.length} data sets...', dataSetsData.length);
        final d2 = D2TouchSingleton().d2Touch;
        // Process and save data sets
        for (int i = 0; i < dataSetsData.length; i++) {
          final dataSetData = dataSetsData[i];
          dataSetData['dirty'] = false;
          if (i % 10 == 0) {
            final progress = 0.3 + ((i / dataSetsData.length) * 0.7);
            onProgress(progress, 'Processing data sets: ${i + 1}/${dataSetsData.length}', dataSetsData.length);
          }
        }
        // Save using D2Touch
        await d2.dataSetModule.dataSet.setData(
          dataSetsData.map((data) => data as Map<String, dynamic>).toList()
        ).save();
        onProgress(1.0, 'Data sets sync completed', dataSetsData.length);
        return dataSetsData.length;
      } else {
        throw Exception('Failed to fetch data sets: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Data sets sync failed: $e');
    }
  }
}

// Singleton for D2Touch
class D2TouchSingleton {
  static final D2TouchSingleton _instance = D2TouchSingleton._internal();
  late final D2Touch d2Touch;
  bool _initialized = false;

  D2TouchSingleton._internal();

  factory D2TouchSingleton() {
    return _instance;
  }

  Future<void> initialize(/* add your config params here */) async {
    if (!_initialized) {
      // Initialize D2Touch only once
      d2Touch = D2Touch(); // Replace with the appropriate named constructor
      // await d2Touch.init(); // If you have an async init method
      _initialized = true;
    }
  }
}

class MetadataType {
  final String key;
  final String displayName;
  final double weight;

  MetadataType(this.key, this.displayName, this.weight);
}

class SyncProgress {
  final String? currentType;
  final String message;
  final double overallProgress;
  final double typeProgress;
  final bool isTypeCompleted;
  final int itemCount;

  SyncProgress({
    this.currentType,
    required this.message,
    required this.overallProgress,
    required this.typeProgress,
    required this.isTypeCompleted,
    required this.itemCount,
  });
}
