// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organisation_unit_isar.entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOrganisationUnitIsarCollection on Isar {
  IsarCollection<OrganisationUnitIsar> get organisationUnitIsars =>
      this.collection();
}

const OrganisationUnitIsarSchema = CollectionSchema(
  name: r'OrganisationUnitIsar',
  id: 6956208484976723675,
  properties: {
    r'ancestorIds': PropertySchema(
      id: 0,
      name: r'ancestorIds',
      type: IsarType.stringList,
    ),
    r'childrenIds': PropertySchema(
      id: 1,
      name: r'childrenIds',
      type: IsarType.stringList,
    ),
    r'code': PropertySchema(
      id: 2,
      name: r'code',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'createdTimestamp': PropertySchema(
      id: 4,
      name: r'createdTimestamp',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 5,
      name: r'description',
      type: IsarType.string,
    ),
    r'dhis2Id': PropertySchema(
      id: 6,
      name: r'dhis2Id',
      type: IsarType.string,
    ),
    r'dirty': PropertySchema(
      id: 7,
      name: r'dirty',
      type: IsarType.bool,
    ),
    r'displayName': PropertySchema(
      id: 8,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'displayNameValue': PropertySchema(
      id: 9,
      name: r'displayNameValue',
      type: IsarType.string,
    ),
    r'effectiveDisplayName': PropertySchema(
      id: 10,
      name: r'effectiveDisplayName',
      type: IsarType.string,
    ),
    r'effectiveShortName': PropertySchema(
      id: 11,
      name: r'effectiveShortName',
      type: IsarType.string,
    ),
    r'externalAccess': PropertySchema(
      id: 12,
      name: r'externalAccess',
      type: IsarType.bool,
    ),
    r'geometryJson': PropertySchema(
      id: 13,
      name: r'geometryJson',
      type: IsarType.string,
    ),
    r'hasCoordinates': PropertySchema(
      id: 14,
      name: r'hasCoordinates',
      type: IsarType.bool,
    ),
    r'hashCode': PropertySchema(
      id: 15,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'hierarchyDisplay': PropertySchema(
      id: 16,
      name: r'hierarchyDisplay',
      type: IsarType.string,
    ),
    r'isLeaf': PropertySchema(
      id: 17,
      name: r'isLeaf',
      type: IsarType.bool,
    ),
    r'isRoot': PropertySchema(
      id: 18,
      name: r'isRoot',
      type: IsarType.bool,
    ),
    r'isValidDhis2Entity': PropertySchema(
      id: 19,
      name: r'isValidDhis2Entity',
      type: IsarType.bool,
    ),
    r'lastUpdatedAt': PropertySchema(
      id: 20,
      name: r'lastUpdatedAt',
      type: IsarType.dateTime,
    ),
    r'lastUpdatedTimestamp': PropertySchema(
      id: 21,
      name: r'lastUpdatedTimestamp',
      type: IsarType.long,
    ),
    r'latitude': PropertySchema(
      id: 22,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'level': PropertySchema(
      id: 23,
      name: r'level',
      type: IsarType.long,
    ),
    r'longitude': PropertySchema(
      id: 24,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 25,
      name: r'name',
      type: IsarType.string,
    ),
    r'openingDate': PropertySchema(
      id: 26,
      name: r'openingDate',
      type: IsarType.string,
    ),
    r'openingDateTimestamp': PropertySchema(
      id: 27,
      name: r'openingDateTimestamp',
      type: IsarType.long,
    ),
    r'openingDate_DateTime': PropertySchema(
      id: 28,
      name: r'openingDate_DateTime',
      type: IsarType.dateTime,
    ),
    r'parentId': PropertySchema(
      id: 29,
      name: r'parentId',
      type: IsarType.string,
    ),
    r'path': PropertySchema(
      id: 30,
      name: r'path',
      type: IsarType.string,
    ),
    r'searchableText': PropertySchema(
      id: 31,
      name: r'searchableText',
      type: IsarType.string,
    ),
    r'serverCreated': PropertySchema(
      id: 32,
      name: r'serverCreated',
      type: IsarType.string,
    ),
    r'serverLastUpdated': PropertySchema(
      id: 33,
      name: r'serverLastUpdated',
      type: IsarType.string,
    ),
    r'shortName': PropertySchema(
      id: 34,
      name: r'shortName',
      type: IsarType.string,
    ),
    r'synced': PropertySchema(
      id: 35,
      name: r'synced',
      type: IsarType.bool,
    ),
    r'translationsJson': PropertySchema(
      id: 36,
      name: r'translationsJson',
      type: IsarType.string,
    )
  },
  estimateSize: _organisationUnitIsarEstimateSize,
  serialize: _organisationUnitIsarSerialize,
  deserialize: _organisationUnitIsarDeserialize,
  deserializeProp: _organisationUnitIsarDeserializeProp,
  idName: r'id',
  indexes: {
    r'level': IndexSchema(
      id: -730704511986726349,
      name: r'level',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'level',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'path': IndexSchema(
      id: 8756705481922369689,
      name: r'path',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'path',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'openingDateTimestamp': IndexSchema(
      id: -2401967759719862430,
      name: r'openingDateTimestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'openingDateTimestamp',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'parentId': IndexSchema(
      id: -809199838039056779,
      name: r'parentId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'parentId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isLeaf': IndexSchema(
      id: 8104774745319105837,
      name: r'isLeaf',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isLeaf',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isRoot': IndexSchema(
      id: 1865266780102491892,
      name: r'isRoot',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isRoot',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'code': IndexSchema(
      id: 329780482934683790,
      name: r'code',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'code',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'dhis2Id': IndexSchema(
      id: 1537626387770127674,
      name: r'dhis2Id',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dhis2Id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'dirty': IndexSchema(
      id: 624608328996418504,
      name: r'dirty',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dirty',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'createdTimestamp': IndexSchema(
      id: -6330424217074401074,
      name: r'createdTimestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdTimestamp',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'lastUpdatedTimestamp': IndexSchema(
      id: -5041984829781674707,
      name: r'lastUpdatedTimestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lastUpdatedTimestamp',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'synced': IndexSchema(
      id: -4832663256418428922,
      name: r'synced',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'synced',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _organisationUnitIsarGetId,
  getLinks: _organisationUnitIsarGetLinks,
  attach: _organisationUnitIsarAttach,
  version: '3.1.0+1',
);

int _organisationUnitIsarEstimateSize(
  OrganisationUnitIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.ancestorIds;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.childrenIds;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.code;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.dhis2Id.length * 3;
  bytesCount += 3 + object.displayName.length * 3;
  {
    final value = object.displayNameValue;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.effectiveDisplayName.length * 3;
  bytesCount += 3 + object.effectiveShortName.length * 3;
  {
    final value = object.geometryJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.hierarchyDisplay.length * 3;
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.openingDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.parentId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.path;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.searchableText.length * 3;
  {
    final value = object.serverCreated;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.serverLastUpdated;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.shortName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.translationsJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _organisationUnitIsarSerialize(
  OrganisationUnitIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.ancestorIds);
  writer.writeStringList(offsets[1], object.childrenIds);
  writer.writeString(offsets[2], object.code);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeLong(offsets[4], object.createdTimestamp);
  writer.writeString(offsets[5], object.description);
  writer.writeString(offsets[6], object.dhis2Id);
  writer.writeBool(offsets[7], object.dirty);
  writer.writeString(offsets[8], object.displayName);
  writer.writeString(offsets[9], object.displayNameValue);
  writer.writeString(offsets[10], object.effectiveDisplayName);
  writer.writeString(offsets[11], object.effectiveShortName);
  writer.writeBool(offsets[12], object.externalAccess);
  writer.writeString(offsets[13], object.geometryJson);
  writer.writeBool(offsets[14], object.hasCoordinates);
  writer.writeLong(offsets[15], object.hashCode);
  writer.writeString(offsets[16], object.hierarchyDisplay);
  writer.writeBool(offsets[17], object.isLeaf);
  writer.writeBool(offsets[18], object.isRoot);
  writer.writeBool(offsets[19], object.isValidDhis2Entity);
  writer.writeDateTime(offsets[20], object.lastUpdatedAt);
  writer.writeLong(offsets[21], object.lastUpdatedTimestamp);
  writer.writeDouble(offsets[22], object.latitude);
  writer.writeLong(offsets[23], object.level);
  writer.writeDouble(offsets[24], object.longitude);
  writer.writeString(offsets[25], object.name);
  writer.writeString(offsets[26], object.openingDate);
  writer.writeLong(offsets[27], object.openingDateTimestamp);
  writer.writeDateTime(offsets[28], object.openingDate_DateTime);
  writer.writeString(offsets[29], object.parentId);
  writer.writeString(offsets[30], object.path);
  writer.writeString(offsets[31], object.searchableText);
  writer.writeString(offsets[32], object.serverCreated);
  writer.writeString(offsets[33], object.serverLastUpdated);
  writer.writeString(offsets[34], object.shortName);
  writer.writeBool(offsets[35], object.synced);
  writer.writeString(offsets[36], object.translationsJson);
}

OrganisationUnitIsar _organisationUnitIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OrganisationUnitIsar();
  object.ancestorIds = reader.readStringList(offsets[0]);
  object.childrenIds = reader.readStringList(offsets[1]);
  object.code = reader.readStringOrNull(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.createdTimestamp = reader.readLong(offsets[4]);
  object.description = reader.readStringOrNull(offsets[5]);
  object.dhis2Id = reader.readString(offsets[6]);
  object.dirty = reader.readBool(offsets[7]);
  object.displayNameValue = reader.readStringOrNull(offsets[9]);
  object.externalAccess = reader.readBoolOrNull(offsets[12]);
  object.geometryJson = reader.readStringOrNull(offsets[13]);
  object.id = id;
  object.isLeaf = reader.readBool(offsets[17]);
  object.lastUpdatedAt = reader.readDateTime(offsets[20]);
  object.lastUpdatedTimestamp = reader.readLong(offsets[21]);
  object.latitude = reader.readDoubleOrNull(offsets[22]);
  object.level = reader.readLongOrNull(offsets[23]);
  object.longitude = reader.readDoubleOrNull(offsets[24]);
  object.name = reader.readString(offsets[25]);
  object.openingDate = reader.readStringOrNull(offsets[26]);
  object.openingDateTimestamp = reader.readLongOrNull(offsets[27]);
  object.openingDate_DateTime = reader.readDateTimeOrNull(offsets[28]);
  object.parentId = reader.readStringOrNull(offsets[29]);
  object.path = reader.readStringOrNull(offsets[30]);
  object.serverCreated = reader.readStringOrNull(offsets[32]);
  object.serverLastUpdated = reader.readStringOrNull(offsets[33]);
  object.shortName = reader.readStringOrNull(offsets[34]);
  object.synced = reader.readBool(offsets[35]);
  object.translationsJson = reader.readStringOrNull(offsets[36]);
  return object;
}

P _organisationUnitIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readBoolOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readBool(offset)) as P;
    case 18:
      return (reader.readBool(offset)) as P;
    case 19:
      return (reader.readBool(offset)) as P;
    case 20:
      return (reader.readDateTime(offset)) as P;
    case 21:
      return (reader.readLong(offset)) as P;
    case 22:
      return (reader.readDoubleOrNull(offset)) as P;
    case 23:
      return (reader.readLongOrNull(offset)) as P;
    case 24:
      return (reader.readDoubleOrNull(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (reader.readLongOrNull(offset)) as P;
    case 28:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 29:
      return (reader.readStringOrNull(offset)) as P;
    case 30:
      return (reader.readStringOrNull(offset)) as P;
    case 31:
      return (reader.readString(offset)) as P;
    case 32:
      return (reader.readStringOrNull(offset)) as P;
    case 33:
      return (reader.readStringOrNull(offset)) as P;
    case 34:
      return (reader.readStringOrNull(offset)) as P;
    case 35:
      return (reader.readBool(offset)) as P;
    case 36:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _organisationUnitIsarGetId(OrganisationUnitIsar object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _organisationUnitIsarGetLinks(
    OrganisationUnitIsar object) {
  return [];
}

void _organisationUnitIsarAttach(
    IsarCollection<dynamic> col, Id id, OrganisationUnitIsar object) {
  object.id = id;
}

extension OrganisationUnitIsarQueryWhereSort
    on QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QWhere> {
  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhere>
      anyLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'level'),
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhere>
      anyPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'path'),
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhere>
      anyOpeningDateTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'openingDateTimestamp'),
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhere>
      anyIsLeaf() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isLeaf'),
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhere>
      anyIsRoot() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isRoot'),
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhere>
      anyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'name'),
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhere>
      anyDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dirty'),
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhere>
      anyCreatedTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdTimestamp'),
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhere>
      anyLastUpdatedTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'lastUpdatedTimestamp'),
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhere>
      anySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'synced'),
      );
    });
  }
}

extension OrganisationUnitIsarQueryWhere
    on QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QWhereClause> {
  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      levelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'level',
        value: [null],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      levelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'level',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      levelEqualTo(int? level) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'level',
        value: [level],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      levelNotEqualTo(int? level) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'level',
              lower: [],
              upper: [level],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'level',
              lower: [level],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'level',
              lower: [level],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'level',
              lower: [],
              upper: [level],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      levelGreaterThan(
    int? level, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'level',
        lower: [level],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      levelLessThan(
    int? level, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'level',
        lower: [],
        upper: [level],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      levelBetween(
    int? lowerLevel,
    int? upperLevel, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'level',
        lower: [lowerLevel],
        includeLower: includeLower,
        upper: [upperLevel],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      pathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'path',
        value: [null],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      pathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'path',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      pathEqualTo(String? path) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'path',
        value: [path],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      pathNotEqualTo(String? path) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'path',
              lower: [],
              upper: [path],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'path',
              lower: [path],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'path',
              lower: [path],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'path',
              lower: [],
              upper: [path],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      pathGreaterThan(
    String? path, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'path',
        lower: [path],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      pathLessThan(
    String? path, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'path',
        lower: [],
        upper: [path],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      pathBetween(
    String? lowerPath,
    String? upperPath, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'path',
        lower: [lowerPath],
        includeLower: includeLower,
        upper: [upperPath],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      pathStartsWith(String PathPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'path',
        lower: [PathPrefix],
        upper: ['$PathPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'path',
        value: [''],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'path',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'path',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'path',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'path',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      openingDateTimestampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'openingDateTimestamp',
        value: [null],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      openingDateTimestampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'openingDateTimestamp',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      openingDateTimestampEqualTo(int? openingDateTimestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'openingDateTimestamp',
        value: [openingDateTimestamp],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      openingDateTimestampNotEqualTo(int? openingDateTimestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'openingDateTimestamp',
              lower: [],
              upper: [openingDateTimestamp],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'openingDateTimestamp',
              lower: [openingDateTimestamp],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'openingDateTimestamp',
              lower: [openingDateTimestamp],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'openingDateTimestamp',
              lower: [],
              upper: [openingDateTimestamp],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      openingDateTimestampGreaterThan(
    int? openingDateTimestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'openingDateTimestamp',
        lower: [openingDateTimestamp],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      openingDateTimestampLessThan(
    int? openingDateTimestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'openingDateTimestamp',
        lower: [],
        upper: [openingDateTimestamp],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      openingDateTimestampBetween(
    int? lowerOpeningDateTimestamp,
    int? upperOpeningDateTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'openingDateTimestamp',
        lower: [lowerOpeningDateTimestamp],
        includeLower: includeLower,
        upper: [upperOpeningDateTimestamp],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      parentIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'parentId',
        value: [null],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      parentIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'parentId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      parentIdEqualTo(String? parentId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'parentId',
        value: [parentId],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      parentIdNotEqualTo(String? parentId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'parentId',
              lower: [],
              upper: [parentId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'parentId',
              lower: [parentId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'parentId',
              lower: [parentId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'parentId',
              lower: [],
              upper: [parentId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      isLeafEqualTo(bool isLeaf) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isLeaf',
        value: [isLeaf],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      isLeafNotEqualTo(bool isLeaf) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isLeaf',
              lower: [],
              upper: [isLeaf],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isLeaf',
              lower: [isLeaf],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isLeaf',
              lower: [isLeaf],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isLeaf',
              lower: [],
              upper: [isLeaf],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      isRootEqualTo(bool isRoot) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isRoot',
        value: [isRoot],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      isRootNotEqualTo(bool isRoot) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isRoot',
              lower: [],
              upper: [isRoot],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isRoot',
              lower: [isRoot],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isRoot',
              lower: [isRoot],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isRoot',
              lower: [],
              upper: [isRoot],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      nameGreaterThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [name],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      nameLessThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [],
        upper: [name],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      nameBetween(
    String lowerName,
    String upperName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [lowerName],
        includeLower: includeLower,
        upper: [upperName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      nameStartsWith(String NamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [NamePrefix],
        upper: ['$NamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [''],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      codeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'code',
        value: [null],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      codeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'code',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      codeEqualTo(String? code) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'code',
        value: [code],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      codeNotEqualTo(String? code) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [],
              upper: [code],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [code],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [code],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [],
              upper: [code],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      dhis2IdEqualTo(String dhis2Id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dhis2Id',
        value: [dhis2Id],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      dhis2IdNotEqualTo(String dhis2Id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dhis2Id',
              lower: [],
              upper: [dhis2Id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dhis2Id',
              lower: [dhis2Id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dhis2Id',
              lower: [dhis2Id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dhis2Id',
              lower: [],
              upper: [dhis2Id],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      dirtyEqualTo(bool dirty) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dirty',
        value: [dirty],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      dirtyNotEqualTo(bool dirty) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dirty',
              lower: [],
              upper: [dirty],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dirty',
              lower: [dirty],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dirty',
              lower: [dirty],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dirty',
              lower: [],
              upper: [dirty],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      createdTimestampEqualTo(int createdTimestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdTimestamp',
        value: [createdTimestamp],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      createdTimestampNotEqualTo(int createdTimestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdTimestamp',
              lower: [],
              upper: [createdTimestamp],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdTimestamp',
              lower: [createdTimestamp],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdTimestamp',
              lower: [createdTimestamp],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdTimestamp',
              lower: [],
              upper: [createdTimestamp],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      createdTimestampGreaterThan(
    int createdTimestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdTimestamp',
        lower: [createdTimestamp],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      createdTimestampLessThan(
    int createdTimestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdTimestamp',
        lower: [],
        upper: [createdTimestamp],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      createdTimestampBetween(
    int lowerCreatedTimestamp,
    int upperCreatedTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdTimestamp',
        lower: [lowerCreatedTimestamp],
        includeLower: includeLower,
        upper: [upperCreatedTimestamp],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      lastUpdatedTimestampEqualTo(int lastUpdatedTimestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lastUpdatedTimestamp',
        value: [lastUpdatedTimestamp],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      lastUpdatedTimestampNotEqualTo(int lastUpdatedTimestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastUpdatedTimestamp',
              lower: [],
              upper: [lastUpdatedTimestamp],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastUpdatedTimestamp',
              lower: [lastUpdatedTimestamp],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastUpdatedTimestamp',
              lower: [lastUpdatedTimestamp],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastUpdatedTimestamp',
              lower: [],
              upper: [lastUpdatedTimestamp],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      lastUpdatedTimestampGreaterThan(
    int lastUpdatedTimestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastUpdatedTimestamp',
        lower: [lastUpdatedTimestamp],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      lastUpdatedTimestampLessThan(
    int lastUpdatedTimestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastUpdatedTimestamp',
        lower: [],
        upper: [lastUpdatedTimestamp],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      lastUpdatedTimestampBetween(
    int lowerLastUpdatedTimestamp,
    int upperLastUpdatedTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastUpdatedTimestamp',
        lower: [lowerLastUpdatedTimestamp],
        includeLower: includeLower,
        upper: [upperLastUpdatedTimestamp],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      syncedEqualTo(bool synced) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'synced',
        value: [synced],
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterWhereClause>
      syncedNotEqualTo(bool synced) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'synced',
              lower: [],
              upper: [synced],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'synced',
              lower: [synced],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'synced',
              lower: [synced],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'synced',
              lower: [],
              upper: [synced],
              includeUpper: false,
            ));
      }
    });
  }
}

extension OrganisationUnitIsarQueryFilter on QueryBuilder<OrganisationUnitIsar,
    OrganisationUnitIsar, QFilterCondition> {
  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ancestorIds',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ancestorIds',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ancestorIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ancestorIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ancestorIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ancestorIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ancestorIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ancestorIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      ancestorIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ancestorIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      ancestorIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ancestorIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ancestorIds',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ancestorIds',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ancestorIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ancestorIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ancestorIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ancestorIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ancestorIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> ancestorIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ancestorIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'childrenIds',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'childrenIds',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'childrenIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'childrenIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'childrenIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'childrenIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'childrenIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'childrenIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      childrenIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'childrenIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      childrenIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'childrenIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'childrenIds',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'childrenIds',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'childrenIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'childrenIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'childrenIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'childrenIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'childrenIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> childrenIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'childrenIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> codeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'code',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> codeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'code',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> codeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> codeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> codeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> codeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'code',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> codeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> codeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      codeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      codeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'code',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> codeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> codeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> createdTimestampEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> createdTimestampGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> createdTimestampLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> createdTimestampBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdTimestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> dhis2IdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dhis2Id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> dhis2IdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dhis2Id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> dhis2IdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dhis2Id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> dhis2IdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dhis2Id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> dhis2IdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dhis2Id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> dhis2IdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dhis2Id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      dhis2IdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dhis2Id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      dhis2IdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dhis2Id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> dhis2IdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dhis2Id',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> dhis2IdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dhis2Id',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> dirtyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dirty',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'displayNameValue',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'displayNameValue',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayNameValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameValueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayNameValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameValueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayNameValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameValueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayNameValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayNameValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayNameValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      displayNameValueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayNameValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      displayNameValueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayNameValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayNameValue',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> displayNameValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayNameValue',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveDisplayNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'effectiveDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveDisplayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'effectiveDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveDisplayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'effectiveDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveDisplayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'effectiveDisplayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveDisplayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'effectiveDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveDisplayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'effectiveDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      effectiveDisplayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'effectiveDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      effectiveDisplayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'effectiveDisplayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveDisplayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'effectiveDisplayName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveDisplayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'effectiveDisplayName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveShortNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'effectiveShortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveShortNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'effectiveShortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveShortNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'effectiveShortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveShortNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'effectiveShortName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveShortNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'effectiveShortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveShortNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'effectiveShortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      effectiveShortNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'effectiveShortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      effectiveShortNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'effectiveShortName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveShortNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'effectiveShortName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> effectiveShortNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'effectiveShortName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> externalAccessIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'externalAccess',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> externalAccessIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'externalAccess',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> externalAccessEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'externalAccess',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> geometryJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'geometryJson',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> geometryJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'geometryJson',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> geometryJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'geometryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> geometryJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'geometryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> geometryJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'geometryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> geometryJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'geometryJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> geometryJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'geometryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> geometryJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'geometryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      geometryJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'geometryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      geometryJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'geometryJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> geometryJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'geometryJson',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> geometryJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'geometryJson',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hasCoordinatesEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasCoordinates',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hierarchyDisplayEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hierarchyDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hierarchyDisplayGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hierarchyDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hierarchyDisplayLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hierarchyDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hierarchyDisplayBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hierarchyDisplay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hierarchyDisplayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hierarchyDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hierarchyDisplayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hierarchyDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      hierarchyDisplayContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hierarchyDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      hierarchyDisplayMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hierarchyDisplay',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hierarchyDisplayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hierarchyDisplay',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> hierarchyDisplayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hierarchyDisplay',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> isLeafEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLeaf',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> isRootEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRoot',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> isValidDhis2EntityEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isValidDhis2Entity',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> lastUpdatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> lastUpdatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> lastUpdatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> lastUpdatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> lastUpdatedTimestampEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdatedTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> lastUpdatedTimestampGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdatedTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> lastUpdatedTimestampLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdatedTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> lastUpdatedTimestampBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdatedTimestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> latitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> latitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latitude',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> latitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> latitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> latitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> latitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> levelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'level',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> levelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'level',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> levelEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> levelGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> levelLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> levelBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'level',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> longitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> longitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'longitude',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> longitudeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> longitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> longitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> longitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'openingDate',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'openingDate',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openingDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openingDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openingDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openingDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'openingDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'openingDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      openingDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'openingDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      openingDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'openingDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openingDate',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'openingDate',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateTimestampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'openingDateTimestamp',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateTimestampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'openingDateTimestamp',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateTimestampEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openingDateTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateTimestampGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openingDateTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateTimestampLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openingDateTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDateTimestampBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openingDateTimestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDate_DateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'openingDate_DateTime',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDate_DateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'openingDate_DateTime',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDate_DateTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openingDate_DateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDate_DateTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openingDate_DateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDate_DateTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openingDate_DateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> openingDate_DateTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openingDate_DateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> parentIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentId',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> parentIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentId',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> parentIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> parentIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> parentIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> parentIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> parentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> parentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      parentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      parentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> parentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentId',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> parentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentId',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> pathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'path',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> pathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'path',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> pathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> pathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> pathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> pathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> pathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> pathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      pathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      pathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> searchableTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchableText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> searchableTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchableText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> searchableTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchableText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> searchableTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchableText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> searchableTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'searchableText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> searchableTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'searchableText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      searchableTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'searchableText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      searchableTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'searchableText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> searchableTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchableText',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> searchableTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'searchableText',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverCreatedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'serverCreated',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverCreatedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'serverCreated',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverCreatedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverCreated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverCreatedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverCreated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverCreatedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverCreated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverCreatedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverCreated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverCreatedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serverCreated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverCreatedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serverCreated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      serverCreatedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serverCreated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      serverCreatedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serverCreated',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverCreatedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverCreated',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverCreatedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serverCreated',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverLastUpdatedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'serverLastUpdated',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverLastUpdatedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'serverLastUpdated',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverLastUpdatedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverLastUpdated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverLastUpdatedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverLastUpdated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverLastUpdatedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverLastUpdated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverLastUpdatedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverLastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverLastUpdatedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serverLastUpdated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverLastUpdatedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serverLastUpdated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      serverLastUpdatedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serverLastUpdated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      serverLastUpdatedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serverLastUpdated',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverLastUpdatedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverLastUpdated',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> serverLastUpdatedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serverLastUpdated',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> shortNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shortName',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> shortNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shortName',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> shortNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> shortNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> shortNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> shortNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shortName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> shortNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> shortNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      shortNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shortName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      shortNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shortName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> shortNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> shortNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shortName',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> syncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'synced',
        value: value,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> translationsJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'translationsJson',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> translationsJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'translationsJson',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> translationsJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'translationsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> translationsJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'translationsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> translationsJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'translationsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> translationsJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'translationsJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> translationsJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'translationsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> translationsJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'translationsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      translationsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'translationsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
          QAfterFilterCondition>
      translationsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'translationsJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> translationsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'translationsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar,
      QAfterFilterCondition> translationsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'translationsJson',
        value: '',
      ));
    });
  }
}

extension OrganisationUnitIsarQueryObject on QueryBuilder<OrganisationUnitIsar,
    OrganisationUnitIsar, QFilterCondition> {}

extension OrganisationUnitIsarQueryLinks on QueryBuilder<OrganisationUnitIsar,
    OrganisationUnitIsar, QFilterCondition> {}

extension OrganisationUnitIsarQuerySortBy
    on QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QSortBy> {
  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByCreatedTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdTimestamp', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByCreatedTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdTimestamp', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByDhis2Id() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhis2Id', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByDhis2IdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhis2Id', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dirty', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dirty', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByDisplayNameValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayNameValue', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByDisplayNameValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayNameValue', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByEffectiveDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveDisplayName', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByEffectiveDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveDisplayName', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByEffectiveShortName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveShortName', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByEffectiveShortNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveShortName', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByExternalAccess() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalAccess', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByExternalAccessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalAccess', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByGeometryJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geometryJson', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByGeometryJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geometryJson', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByHasCoordinates() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCoordinates', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByHasCoordinatesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCoordinates', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByHierarchyDisplay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hierarchyDisplay', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByHierarchyDisplayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hierarchyDisplay', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByIsLeaf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLeaf', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByIsLeafDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLeaf', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByIsRoot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRoot', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByIsRootDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRoot', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByIsValidDhis2Entity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValidDhis2Entity', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByIsValidDhis2EntityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValidDhis2Entity', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByLastUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedAt', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByLastUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedAt', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByLastUpdatedTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedTimestamp', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByLastUpdatedTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedTimestamp', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByOpeningDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingDate', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByOpeningDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingDate', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByOpeningDateTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingDateTimestamp', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByOpeningDateTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingDateTimestamp', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByOpeningDate_DateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingDate_DateTime', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByOpeningDate_DateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingDate_DateTime', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByParentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByParentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortBySearchableText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchableText', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortBySearchableTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchableText', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByServerCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverCreated', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByServerCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverCreated', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByServerLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverLastUpdated', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByServerLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverLastUpdated', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByShortName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortName', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByShortNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortName', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByTranslationsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translationsJson', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      sortByTranslationsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translationsJson', Sort.desc);
    });
  }
}

extension OrganisationUnitIsarQuerySortThenBy
    on QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QSortThenBy> {
  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByCreatedTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdTimestamp', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByCreatedTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdTimestamp', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByDhis2Id() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhis2Id', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByDhis2IdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dhis2Id', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dirty', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByDirtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dirty', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByDisplayNameValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayNameValue', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByDisplayNameValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayNameValue', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByEffectiveDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveDisplayName', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByEffectiveDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveDisplayName', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByEffectiveShortName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveShortName', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByEffectiveShortNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'effectiveShortName', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByExternalAccess() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalAccess', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByExternalAccessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalAccess', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByGeometryJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geometryJson', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByGeometryJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geometryJson', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByHasCoordinates() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCoordinates', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByHasCoordinatesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCoordinates', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByHierarchyDisplay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hierarchyDisplay', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByHierarchyDisplayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hierarchyDisplay', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByIsLeaf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLeaf', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByIsLeafDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLeaf', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByIsRoot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRoot', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByIsRootDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRoot', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByIsValidDhis2Entity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValidDhis2Entity', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByIsValidDhis2EntityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isValidDhis2Entity', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByLastUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedAt', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByLastUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedAt', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByLastUpdatedTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedTimestamp', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByLastUpdatedTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedTimestamp', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByOpeningDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingDate', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByOpeningDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingDate', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByOpeningDateTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingDateTimestamp', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByOpeningDateTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingDateTimestamp', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByOpeningDate_DateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingDate_DateTime', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByOpeningDate_DateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openingDate_DateTime', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByParentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByParentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenBySearchableText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchableText', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenBySearchableTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchableText', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByServerCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverCreated', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByServerCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverCreated', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByServerLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverLastUpdated', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByServerLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverLastUpdated', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByShortName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortName', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByShortNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortName', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByTranslationsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translationsJson', Sort.asc);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QAfterSortBy>
      thenByTranslationsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'translationsJson', Sort.desc);
    });
  }
}

extension OrganisationUnitIsarQueryWhereDistinct
    on QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct> {
  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByAncestorIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ancestorIds');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByChildrenIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'childrenIds');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'code', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByCreatedTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdTimestamp');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByDhis2Id({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dhis2Id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByDirty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dirty');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByDisplayNameValue({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayNameValue',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByEffectiveDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'effectiveDisplayName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByEffectiveShortName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'effectiveShortName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByExternalAccess() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'externalAccess');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByGeometryJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'geometryJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByHasCoordinates() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasCoordinates');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByHierarchyDisplay({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hierarchyDisplay',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByIsLeaf() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLeaf');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByIsRoot() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRoot');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByIsValidDhis2Entity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isValidDhis2Entity');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByLastUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdatedAt');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByLastUpdatedTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdatedTimestamp');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'level');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByOpeningDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openingDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByOpeningDateTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openingDateTimestamp');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByOpeningDate_DateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openingDate_DateTime');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByParentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctBySearchableText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchableText',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByServerCreated({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serverCreated',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByServerLastUpdated({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serverLastUpdated',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByShortName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shortName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'synced');
    });
  }

  QueryBuilder<OrganisationUnitIsar, OrganisationUnitIsar, QDistinct>
      distinctByTranslationsJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'translationsJson',
          caseSensitive: caseSensitive);
    });
  }
}

extension OrganisationUnitIsarQueryProperty on QueryBuilder<
    OrganisationUnitIsar, OrganisationUnitIsar, QQueryProperty> {
  QueryBuilder<OrganisationUnitIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OrganisationUnitIsar, List<String>?, QQueryOperations>
      ancestorIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ancestorIds');
    });
  }

  QueryBuilder<OrganisationUnitIsar, List<String>?, QQueryOperations>
      childrenIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'childrenIds');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String?, QQueryOperations> codeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'code');
    });
  }

  QueryBuilder<OrganisationUnitIsar, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<OrganisationUnitIsar, int, QQueryOperations>
      createdTimestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdTimestamp');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String, QQueryOperations>
      dhis2IdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dhis2Id');
    });
  }

  QueryBuilder<OrganisationUnitIsar, bool, QQueryOperations> dirtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dirty');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String, QQueryOperations>
      displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String?, QQueryOperations>
      displayNameValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayNameValue');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String, QQueryOperations>
      effectiveDisplayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'effectiveDisplayName');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String, QQueryOperations>
      effectiveShortNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'effectiveShortName');
    });
  }

  QueryBuilder<OrganisationUnitIsar, bool?, QQueryOperations>
      externalAccessProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'externalAccess');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String?, QQueryOperations>
      geometryJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'geometryJson');
    });
  }

  QueryBuilder<OrganisationUnitIsar, bool, QQueryOperations>
      hasCoordinatesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasCoordinates');
    });
  }

  QueryBuilder<OrganisationUnitIsar, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String, QQueryOperations>
      hierarchyDisplayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hierarchyDisplay');
    });
  }

  QueryBuilder<OrganisationUnitIsar, bool, QQueryOperations> isLeafProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLeaf');
    });
  }

  QueryBuilder<OrganisationUnitIsar, bool, QQueryOperations> isRootProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRoot');
    });
  }

  QueryBuilder<OrganisationUnitIsar, bool, QQueryOperations>
      isValidDhis2EntityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isValidDhis2Entity');
    });
  }

  QueryBuilder<OrganisationUnitIsar, DateTime, QQueryOperations>
      lastUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdatedAt');
    });
  }

  QueryBuilder<OrganisationUnitIsar, int, QQueryOperations>
      lastUpdatedTimestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdatedTimestamp');
    });
  }

  QueryBuilder<OrganisationUnitIsar, double?, QQueryOperations>
      latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<OrganisationUnitIsar, int?, QQueryOperations> levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'level');
    });
  }

  QueryBuilder<OrganisationUnitIsar, double?, QQueryOperations>
      longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String?, QQueryOperations>
      openingDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openingDate');
    });
  }

  QueryBuilder<OrganisationUnitIsar, int?, QQueryOperations>
      openingDateTimestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openingDateTimestamp');
    });
  }

  QueryBuilder<OrganisationUnitIsar, DateTime?, QQueryOperations>
      openingDate_DateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openingDate_DateTime');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String?, QQueryOperations>
      parentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentId');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String?, QQueryOperations> pathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'path');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String, QQueryOperations>
      searchableTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchableText');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String?, QQueryOperations>
      serverCreatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serverCreated');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String?, QQueryOperations>
      serverLastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serverLastUpdated');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String?, QQueryOperations>
      shortNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shortName');
    });
  }

  QueryBuilder<OrganisationUnitIsar, bool, QQueryOperations> syncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'synced');
    });
  }

  QueryBuilder<OrganisationUnitIsar, String?, QQueryOperations>
      translationsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'translationsJson');
    });
  }
}
