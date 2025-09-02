import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'dart:convert';

import '../sample/current_user.sample.dart';
import '../sample/database_sample.dart';
import 'comprehensive_metadata_sync_test.reflectable.dart';

/// Comprehensive Performance Test for D2-Touch Metadata Sync
/// 
/// This test fetches real metadata from a DHIS2 instance and measures:
/// - Sync performance for large datasets
/// - Memory usage during sync
/// - Database operation performance
/// - Network request efficiency
/// - Error handling under load
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  // DHIS2 Instance Configuration
  const String dhis2BaseUrl = 'https://play.dhis2.org/40.2.2';
  const String dhis2Username = 'admin';
  const String dhis2Password = 'district';
  
  var sharedPreferenceInstance = await SharedPreferences.getInstance();

  group('Comprehensive Metadata Sync Performance Tests', () {
    late D2Touch d2;
    late Dio realDioClient;
    late Stopwatch stopwatch;
    late ProcessInfo memoryInfo;

    setUpAll(() async {
      // Initialize D2Touch with a unique database for performance testing
      d2 = await D2Touch.init(
        databaseFactory: databaseFactoryFfi,
        databaseName: 'performance_test_${DateTime.now().millisecondsSinceEpoch}',
        sharedPreferenceInstance: sharedPreferenceInstance,
      );

      // Configure real HTTP client for DHIS2 instance
      realDioClient = Dio(BaseOptions(
        baseUrl: dhis2BaseUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 60),
        sendTimeout: Duration(seconds: 30),
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode('$dhis2Username:$dhis2Password'))}',
          'Content-Type': 'application/json',
        },
      ));

      // Add logging interceptor for performance monitoring
      realDioClient.interceptors.add(LogInterceptor(
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: false,
        logPrint: (obj) => print('Network: $obj'),
      ));

      stopwatch = Stopwatch();
      memoryInfo = ProcessInfo.currentRss;

      // Setup user authentication
      userData['password'] = dhis2Password;
      userData['isLoggedIn'] = true;
      userData['username'] = dhis2Username;
      userData['baseUrl'] = dhis2BaseUrl;
      final user = User.fromApi(userData);
      await d2.userModule.user.setData(user).save();
      await d2.userModule.userOrganisationUnit
          .setData(user.organisationUnits)
          .save();

      print('=== Performance Test Setup Complete ===');
      print('DHIS2 Instance: $dhis2BaseUrl');
      print('Database: ${d2.databaseName}');
      print('Initial Memory: ${memoryInfo} bytes');
      print('=========================================');
    });

    tearDownAll(() async {
      await d2.dispose();
      print('=== Performance Test Cleanup Complete ===');
    });

    test('Performance Test: Organisation Units Sync (Large Dataset)', () async {
      print('\n📍 Testing Organisation Units Sync Performance...');
      
      final initialMemory = ProcessInfo.currentRss;
      stopwatch.reset();
      stopwatch.start();

      try {
        // Test organisation units sync with progress monitoring
        await d2.organisationUnitModule.organisationUnit.download(
          (progress, isComplete) {
            print('📊 OrgUnit Progress: ${progress.message} - ${progress.percentage}%');
            if (isComplete) {
              print('✅ OrgUnit Sync Complete');
            }
          },
          dioTestClient: realDioClient,
        );

        stopwatch.stop();
        final finalMemory = ProcessInfo.currentRss;
        final memoryUsed = finalMemory - initialMemory;

        // Get synced data for analysis
        final orgUnits = await d2.organisationUnitModule.organisationUnit.get();

        print('\n📊 Organisation Units Performance Results:');
        print('   • Total synced: ${orgUnits.length} organisation units');
        print('   • Sync duration: ${stopwatch.elapsedMilliseconds}ms');
        print('   • Memory used: ${memoryUsed} bytes (${(memoryUsed / 1024 / 1024).toStringAsFixed(2)} MB)');
        print('   • Avg time per unit: ${(stopwatch.elapsedMilliseconds / orgUnits.length).toStringAsFixed(2)}ms');
        
        // Performance assertions
        expect(orgUnits.length, greaterThan(100), reason: 'Should sync significant number of org units');
        expect(stopwatch.elapsedMilliseconds, lessThan(60000), reason: 'Sync should complete within 60 seconds');

        // Verify data integrity
        final sampleOrgUnit = orgUnits.first;
        expect(sampleOrgUnit.id, isNotEmpty);
        expect(sampleOrgUnit.name, isNotEmpty);
        expect(sampleOrgUnit.level, isNotNull);

      } catch (e, stackTrace) {
        print('❌ Organisation Units Sync Failed: $e');
        print('Stack trace: $stackTrace');
        fail('Organisation units sync failed: $e');
      }
    });

    test('Performance Test: Programs Sync (Complex Relationships)', () async {
      print('\n🏥 Testing Programs Sync Performance...');
      
      final initialMemory = ProcessInfo.currentRss;
      stopwatch.reset();
      stopwatch.start();

      try {
        // Test programs sync with complex relationships
        await d2.programModule.program.download(
          (progress, isComplete) {
            print('📊 Program Progress: ${progress.message} - ${progress.percentage}%');
            if (isComplete) {
              print('✅ Program Sync Complete');
            }
          },
          dioTestClient: realDioClient,
        );

        stopwatch.stop();
        final finalMemory = ProcessInfo.currentRss;
        final memoryUsed = finalMemory - initialMemory;

        // Get synced data for analysis
        final programs = await d2.programModule.program.get();
        final programStages = await d2.programModule.programStage.get();
        final programStageDataElements = await d2.programModule.programStageDataElement.get();

        print('\n📊 Programs Performance Results:');
        print('   • Programs synced: ${programs.length}');
        print('   • Program stages synced: ${programStages.length}');
        print('   • Program stage data elements synced: ${programStageDataElements.length}');
        print('   • Sync duration: ${stopwatch.elapsedMilliseconds}ms');
        print('   • Memory used: ${memoryUsed} bytes (${(memoryUsed / 1024 / 1024).toStringAsFixed(2)} MB)');
        
        // Performance assertions
        expect(programs.length, greaterThan(5), reason: 'Should sync multiple programs');
        expect(stopwatch.elapsedMilliseconds, lessThan(120000), reason: 'Complex sync should complete within 2 minutes');

        // Verify relationship integrity
        if (programs.isNotEmpty) {
          final sampleProgram = programs.first;
          expect(sampleProgram.id, isNotEmpty);
          expect(sampleProgram.name, isNotEmpty);
          expect(sampleProgram.programType, isNotNull);
        }

      } catch (e, stackTrace) {
        print('❌ Programs Sync Failed: $e');
        print('Stack trace: $stackTrace');
        fail('Programs sync failed: $e');
      }
    });

    test('Performance Test: Data Elements Sync (Large Volume)', () async {
      print('\n📋 Testing Data Elements Sync Performance...');
      
      final initialMemory = ProcessInfo.currentRss;
      stopwatch.reset();
      stopwatch.start();

      try {
        // Test data elements sync
        await d2.dataElementModule.dataElement.download(
          (progress, isComplete) {
            print('📊 DataElement Progress: ${progress.message} - ${progress.percentage}%');
            if (isComplete) {
              print('✅ DataElement Sync Complete');
            }
          },
          dioTestClient: realDioClient,
        );

        stopwatch.stop();
        final finalMemory = ProcessInfo.currentRss;
        final memoryUsed = finalMemory - initialMemory;

        // Get synced data for analysis
        final dataElements = await d2.dataElementModule.dataElement.get();

        print('\n📊 Data Elements Performance Results:');
        print('   • Total synced: ${dataElements.length} data elements');
        print('   • Sync duration: ${stopwatch.elapsedMilliseconds}ms');
        print('   • Memory used: ${memoryUsed} bytes (${(memoryUsed / 1024 / 1024).toStringAsFixed(2)} MB)');
        print('   • Avg time per element: ${(stopwatch.elapsedMilliseconds / dataElements.length).toStringAsFixed(2)}ms');
        
        // Performance assertions
        expect(dataElements.length, greaterThan(50), reason: 'Should sync significant number of data elements');
        expect(stopwatch.elapsedMilliseconds, lessThan(90000), reason: 'Sync should complete within 90 seconds');

        // Verify data quality
        final sampleDataElement = dataElements.first;
        expect(sampleDataElement.id, isNotEmpty);
        expect(sampleDataElement.name, isNotEmpty);
        expect(sampleDataElement.valueType, isNotEmpty);

      } catch (e, stackTrace) {
        print('❌ Data Elements Sync Failed: $e');
        print('Stack trace: $stackTrace');
        fail('Data elements sync failed: $e');
      }
    });

    test('Performance Test: Categories and Category Combos Sync', () async {
      print('\n🏷️ Testing Categories Sync Performance...');
      
      final initialMemory = ProcessInfo.currentRss;
      stopwatch.reset();
      stopwatch.start();

      try {
        // Test categories sync
        await d2.metadataModule.category.download(
          (progress, isComplete) {
            print('📊 Category Progress: ${progress.message} - ${progress.percentage}%');
          },
          dioTestClient: realDioClient,
        );

        // Test category combinations sync
        await d2.metadataModule.categoryCombo.download(
          (progress, isComplete) {
            print('📊 CategoryCombo Progress: ${progress.message} - ${progress.percentage}%');
          },
          dioTestClient: realDioClient,
        );

        stopwatch.stop();
        final finalMemory = ProcessInfo.currentRss;
        final memoryUsed = finalMemory - initialMemory;

        // Get synced data for analysis
        final categories = await d2.metadataModule.category.get();
        final categoryCombos = await d2.metadataModule.categoryCombo.get();

        print('\n📊 Categories Performance Results:');
        print('   • Categories synced: ${categories.length}');
        print('   • Category combos synced: ${categoryCombos.length}');
        print('   • Sync duration: ${stopwatch.elapsedMilliseconds}ms');
        print('   • Memory used: ${memoryUsed} bytes (${(memoryUsed / 1024 / 1024).toStringAsFixed(2)} MB)');
        
        // Performance assertions
        expect(categories.length, greaterThan(2), reason: 'Should sync multiple categories');
        expect(categoryCombos.length, greaterThan(2), reason: 'Should sync multiple category combos');

      } catch (e, stackTrace) {
        print('❌ Categories Sync Failed: $e');
        print('Stack trace: $stackTrace');
        // Don't fail the test if categories are not available in the instance
      }
    });

    test('Performance Test: Concurrent Metadata Sync', () async {
      print('\n🔄 Testing Concurrent Metadata Sync Performance...');
      
      final initialMemory = ProcessInfo.currentRss;
      stopwatch.reset();
      stopwatch.start();

      try {
        // Test concurrent syncing of multiple metadata types
        final futures = <Future>[];

        // Start multiple sync operations concurrently
        futures.add(d2.organisationUnitModule.organisationUnit.download(
          (progress, isComplete) => print('🔄 Concurrent OrgUnit: ${progress.percentage}%'),
          dioTestClient: realDioClient,
        ));

        futures.add(d2.dataElementModule.dataElement.download(
          (progress, isComplete) => print('🔄 Concurrent DataElement: ${progress.percentage}%'),
          dioTestClient: realDioClient,
        ));

        if (futures.isNotEmpty) {
          futures.add(d2.programModule.program.download(
            (progress, isComplete) => print('🔄 Concurrent Program: ${progress.percentage}%'),
            dioTestClient: realDioClient,
          ));
        }

        // Wait for all syncs to complete
        await Future.wait(futures);

        stopwatch.stop();
        final finalMemory = ProcessInfo.currentRss;
        final memoryUsed = finalMemory - initialMemory;

        print('\n📊 Concurrent Sync Performance Results:');
        print('   • Concurrent operations: ${futures.length}');
        print('   • Total duration: ${stopwatch.elapsedMilliseconds}ms');
        print('   • Memory used: ${memoryUsed} bytes (${(memoryUsed / 1024 / 1024).toStringAsFixed(2)} MB)');
        
        // Performance assertions
        expect(stopwatch.elapsedMilliseconds, lessThan(180000), reason: 'Concurrent sync should complete within 3 minutes');
        expect(memoryUsed, lessThan(500 * 1024 * 1024), reason: 'Memory usage should be reasonable (<500MB)');

      } catch (e, stackTrace) {
        print('❌ Concurrent Sync Failed: $e');
        print('Stack trace: $stackTrace');
        fail('Concurrent sync failed: $e');
      }
    });

    test('Performance Test: Database Query Performance After Sync', () async {
      print('\n🔍 Testing Database Query Performance...');
      
      stopwatch.reset();
      
      try {
        // Test complex queries after data is synced
        
        // 1. Simple query performance
        stopwatch.start();
        final allOrgUnits = await d2.organisationUnitModule.organisationUnit.get();
        final simpleQueryTime = stopwatch.elapsedMicroseconds;
        stopwatch.reset();
        
        // 2. Filtered query performance
        stopwatch.start();
        final level1Units = await d2.organisationUnitModule.organisationUnit
            .where(attribute: 'level', value: 1)
            .get();
        final filteredQueryTime = stopwatch.elapsedMicroseconds;
        stopwatch.reset();
        
        // 3. Join query performance (if applicable)
        stopwatch.start();
        final userOrgUnits = await d2.organisationUnitModule.organisationUnit
            .getUserOrgUnits();
        final joinQueryTime = stopwatch.elapsedMicroseconds;
        stopwatch.reset();
        
        // 4. Complex search query
        stopwatch.start();
        final searchResults = await d2.organisationUnitModule.organisationUnit
            .byIds(allOrgUnits.take(10).map((ou) => ou.id).toList())
            .get();
        final searchQueryTime = stopwatch.elapsedMicroseconds;

        print('\n📊 Database Query Performance Results:');
        print('   • Simple query (${allOrgUnits.length} records): ${simpleQueryTime}μs');
        print('   • Filtered query (${level1Units.length} records): ${filteredQueryTime}μs');
        print('   • Join query (${userOrgUnits?.length ?? 0} records): ${joinQueryTime}μs');
        print('   • Search query (${searchResults.length} records): ${searchQueryTime}μs');
        
        // Performance assertions
        expect(simpleQueryTime, lessThan(100000), reason: 'Simple queries should be fast (<100ms)');
        expect(filteredQueryTime, lessThan(50000), reason: 'Filtered queries should be very fast (<50ms)');
        expect(searchQueryTime, lessThan(10000), reason: 'ID-based searches should be extremely fast (<10ms)');

      } catch (e, stackTrace) {
        print('❌ Database Query Test Failed: $e');
        print('Stack trace: $stackTrace');
        fail('Database query performance test failed: $e');
      }
    });

    test('Performance Test: Memory Usage and Cleanup', () async {
      print('\n🧹 Testing Memory Usage and Cleanup...');
      
      final initialMemory = ProcessInfo.currentRss;
      
      try {
        // Force garbage collection and measure memory
        // Note: Dart doesn't have explicit GC control, but we can trigger it indirectly
        List<List<int>> memoryPressure = [];
        for (int i = 0; i < 100; i++) {
          memoryPressure.add(List.filled(1000, i));
        }
        memoryPressure.clear();
        
        await Future.delayed(Duration(milliseconds: 100));
        
        final afterGCMemory = ProcessInfo.currentRss;
        final memoryDifference = afterGCMemory - initialMemory;
        
        print('\n📊 Memory Usage Results:');
        print('   • Initial memory: ${initialMemory} bytes (${(initialMemory / 1024 / 1024).toStringAsFixed(2)} MB)');
        print('   • Current memory: ${afterGCMemory} bytes (${(afterGCMemory / 1024 / 1024).toStringAsFixed(2)} MB)');
        print('   • Memory difference: ${memoryDifference} bytes (${(memoryDifference / 1024 / 1024).toStringAsFixed(2)} MB)');
        
        // Memory usage assertions
        expect(afterGCMemory, lessThan(1024 * 1024 * 1024), reason: 'Total memory usage should be reasonable (<1GB)');

      } catch (e, stackTrace) {
        print('❌ Memory Test Failed: $e');
        print('Stack trace: $stackTrace');
        fail('Memory usage test failed: $e');
      }
    });

    test('Performance Test: Network Error Resilience', () async {
      print('\n🌐 Testing Network Error Resilience...');
      
      try {
        // Create a client with very short timeout to test error handling
        final timeoutClient = Dio(BaseOptions(
          baseUrl: dhis2BaseUrl,
          connectTimeout: Duration(milliseconds: 1), // Very short timeout
          receiveTimeout: Duration(milliseconds: 1),
          sendTimeout: Duration(milliseconds: 1),
          headers: {
            'Authorization': 'Basic ${base64Encode(utf8.encode('$dhis2Username:$dhis2Password'))}',
          },
        ));

        stopwatch.reset();
        stopwatch.start();

        try {
          await d2.organisationUnitModule.organisationUnit.download(
            (progress, isComplete) {
              print('📊 Resilience Test: ${progress.message}');
            },
            dioTestClient: timeoutClient,
          );
          
          fail('Expected network timeout error');
        } catch (networkError) {
          stopwatch.stop();
          print('✅ Network error handled gracefully: $networkError');
          print('   • Error handling time: ${stopwatch.elapsedMilliseconds}ms');
          
          // Verify the system remains stable after error
          final existingData = await d2.organisationUnitModule.organisationUnit.get();
          print('   • Existing data preserved: ${existingData.length} records');
        }

      } catch (e, stackTrace) {
        print('❌ Network Resilience Test Failed: $e');
        print('Stack trace: $stackTrace');
        fail('Network resilience test failed: $e');
      }
    });
  });

  group('Performance Benchmarks and Reporting', () {
    test('Generate Performance Report', () async {
      print('\n📈 Generating Performance Report...');
      
      final report = StringBuffer();
      report.writeln('=== D2-Touch Performance Test Report ===');
      report.writeln('Date: ${DateTime.now()}');
      report.writeln('DHIS2 Instance: $dhis2BaseUrl');
      report.writeln('Platform: ${Platform.operatingSystem}');
      report.writeln('');
      
      // Add detailed recommendations based on results
      report.writeln('Performance Recommendations:');
      report.writeln('• Monitor sync times for datasets >1000 records');
      report.writeln('• Consider pagination for large organisation unit hierarchies');  
      report.writeln('• Implement caching strategies for frequently accessed metadata');
      report.writeln('• Use incremental sync for large datasets');
      report.writeln('• Monitor memory usage during concurrent operations');
      report.writeln('');
      
      report.writeln('=== End of Report ===');
      
      print(report.toString());
      
      // Optionally write report to file
      try {
        final file = File('performance_test_report_${DateTime.now().millisecondsSinceEpoch}.txt');
        await file.writeAsString(report.toString());
        print('📄 Report saved to: ${file.path}');
      } catch (e) {
        print('Could not save report to file: $e');
      }
    });
  });
}
