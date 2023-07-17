import 'package:d2_touch/modules/metadata/dataset/entities/data_set.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/query_filter.util.dart';
import 'package:sqflite/sqflite.dart';

class DataSetQuery extends BaseQuery<DataSet> {
  DataSetQuery({Database? database}) : super(database: database);

  @override
  Future<String> dhisUrl() {
    final apiFilter =
        QueryFilter.getApiFilters(this.repository.columns, this.query.filters);
    return Future.value(
        'dataSets.json${apiFilter != null ? '?$apiFilter&' : '?'}fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,timelyDays,formType,description,periodType,openFuturePeriods,expiryDays,renderHorizontally,renderAsTabs,fieldCombinationRequired,dataSetElements[dataElement[id,code,name,shortName,aggregationType,domainType,displayName,description,displayShortName,periodOffset,valueType,formName,displayDescription,displayFormName,zeroIsSignificant,optionSetValue,optionSet[id,name,displayName,valueType,options[id,name,displayName,code,sortOrder,displayFormName]]]]&paging=false');
  }
}
