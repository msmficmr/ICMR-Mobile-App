// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaire_db_schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCRAOfflineDataCollection on Isar {
  IsarCollection<CRAOfflineData> get cRAOfflineDatas => this.collection();
}

const CRAOfflineDataSchema = CollectionSchema(
  name: r'CRAOfflineData',
  id: 2758921891071956330,
  properties: {
    r'caseId': PropertySchema(
      id: 0,
      name: r'caseId',
      type: IsarType.string,
    ),
    r'craSectionData': PropertySchema(
      id: 1,
      name: r'craSectionData',
      type: IsarType.objectList,
      target: r'CRASectionModel',
    ),
    r'languageCode': PropertySchema(
      id: 2,
      name: r'languageCode',
      type: IsarType.string,
    ),
    r'patientId': PropertySchema(
      id: 3,
      name: r'patientId',
      type: IsarType.string,
    ),
    r'versionNumber': PropertySchema(
      id: 4,
      name: r'versionNumber',
      type: IsarType.string,
    )
  },
  estimateSize: _cRAOfflineDataEstimateSize,
  serialize: _cRAOfflineDataSerialize,
  deserialize: _cRAOfflineDataDeserialize,
  deserializeProp: _cRAOfflineDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'CRASectionModel': CRASectionModelSchema,
    r'CRAQuestionnaire': CRAQuestionnaireSchema,
    r'Inputs': InputsSchema,
    r'InputsBranch': InputsBranchSchema
  },
  getId: _cRAOfflineDataGetId,
  getLinks: _cRAOfflineDataGetLinks,
  attach: _cRAOfflineDataAttach,
  version: '3.1.0+1',
);

int _cRAOfflineDataEstimateSize(
  CRAOfflineData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.caseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.craSectionData;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CRASectionModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              CRASectionModelSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.languageCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.patientId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.versionNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cRAOfflineDataSerialize(
  CRAOfflineData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.caseId);
  writer.writeObjectList<CRASectionModel>(
    offsets[1],
    allOffsets,
    CRASectionModelSchema.serialize,
    object.craSectionData,
  );
  writer.writeString(offsets[2], object.languageCode);
  writer.writeString(offsets[3], object.patientId);
  writer.writeString(offsets[4], object.versionNumber);
}

CRAOfflineData _cRAOfflineDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CRAOfflineData();
  object.caseId = reader.readStringOrNull(offsets[0]);
  object.craSectionData = reader.readObjectList<CRASectionModel>(
    offsets[1],
    CRASectionModelSchema.deserialize,
    allOffsets,
    CRASectionModel(),
  );
  object.id = id;
  object.languageCode = reader.readStringOrNull(offsets[2]);
  object.patientId = reader.readStringOrNull(offsets[3]);
  object.versionNumber = reader.readStringOrNull(offsets[4]);
  return object;
}

P _cRAOfflineDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectList<CRASectionModel>(
        offset,
        CRASectionModelSchema.deserialize,
        allOffsets,
        CRASectionModel(),
      )) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cRAOfflineDataGetId(CRAOfflineData object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _cRAOfflineDataGetLinks(CRAOfflineData object) {
  return [];
}

void _cRAOfflineDataAttach(
    IsarCollection<dynamic> col, Id id, CRAOfflineData object) {
  object.id = id;
}

extension CRAOfflineDataQueryWhereSort
    on QueryBuilder<CRAOfflineData, CRAOfflineData, QWhere> {
  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CRAOfflineDataQueryWhere
    on QueryBuilder<CRAOfflineData, CRAOfflineData, QWhereClause> {
  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterWhereClause> idBetween(
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
}

extension CRAOfflineDataQueryFilter
    on QueryBuilder<CRAOfflineData, CRAOfflineData, QFilterCondition> {
  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      caseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'caseId',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      caseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'caseId',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      caseIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      caseIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'caseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      caseIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'caseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      caseIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'caseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      caseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'caseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      caseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'caseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      caseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'caseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      caseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'caseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      caseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caseId',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      caseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'caseId',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      craSectionDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'craSectionData',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      craSectionDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'craSectionData',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      craSectionDataLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'craSectionData',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      craSectionDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'craSectionData',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      craSectionDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'craSectionData',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      craSectionDataLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'craSectionData',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      craSectionDataLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'craSectionData',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      craSectionDataLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'craSectionData',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      languageCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'languageCode',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      languageCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'languageCode',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      languageCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      languageCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      languageCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      languageCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'languageCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      languageCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      languageCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      languageCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'languageCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      languageCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'languageCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      languageCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'languageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      languageCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'languageCode',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      patientIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'patientId',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      patientIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'patientId',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      patientIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      patientIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      patientIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      patientIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'patientId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      patientIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      patientIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      patientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      patientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'patientId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      patientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'patientId',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      patientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'patientId',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      versionNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'versionNumber',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      versionNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'versionNumber',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      versionNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      versionNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      versionNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      versionNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'versionNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      versionNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      versionNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      versionNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      versionNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'versionNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      versionNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      versionNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'versionNumber',
        value: '',
      ));
    });
  }
}

extension CRAOfflineDataQueryObject
    on QueryBuilder<CRAOfflineData, CRAOfflineData, QFilterCondition> {
  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterFilterCondition>
      craSectionDataElement(FilterQuery<CRASectionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'craSectionData');
    });
  }
}

extension CRAOfflineDataQueryLinks
    on QueryBuilder<CRAOfflineData, CRAOfflineData, QFilterCondition> {}

extension CRAOfflineDataQuerySortBy
    on QueryBuilder<CRAOfflineData, CRAOfflineData, QSortBy> {
  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy> sortByCaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caseId', Sort.asc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy>
      sortByCaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caseId', Sort.desc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy>
      sortByLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.asc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy>
      sortByLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.desc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy> sortByPatientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.asc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy>
      sortByPatientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.desc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy>
      sortByVersionNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionNumber', Sort.asc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy>
      sortByVersionNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionNumber', Sort.desc);
    });
  }
}

extension CRAOfflineDataQuerySortThenBy
    on QueryBuilder<CRAOfflineData, CRAOfflineData, QSortThenBy> {
  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy> thenByCaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caseId', Sort.asc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy>
      thenByCaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caseId', Sort.desc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy>
      thenByLanguageCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.asc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy>
      thenByLanguageCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'languageCode', Sort.desc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy> thenByPatientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.asc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy>
      thenByPatientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.desc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy>
      thenByVersionNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionNumber', Sort.asc);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QAfterSortBy>
      thenByVersionNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionNumber', Sort.desc);
    });
  }
}

extension CRAOfflineDataQueryWhereDistinct
    on QueryBuilder<CRAOfflineData, CRAOfflineData, QDistinct> {
  QueryBuilder<CRAOfflineData, CRAOfflineData, QDistinct> distinctByCaseId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'caseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QDistinct>
      distinctByLanguageCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'languageCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QDistinct> distinctByPatientId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'patientId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CRAOfflineData, CRAOfflineData, QDistinct>
      distinctByVersionNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionNumber',
          caseSensitive: caseSensitive);
    });
  }
}

extension CRAOfflineDataQueryProperty
    on QueryBuilder<CRAOfflineData, CRAOfflineData, QQueryProperty> {
  QueryBuilder<CRAOfflineData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CRAOfflineData, String?, QQueryOperations> caseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'caseId');
    });
  }

  QueryBuilder<CRAOfflineData, List<CRASectionModel>?, QQueryOperations>
      craSectionDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'craSectionData');
    });
  }

  QueryBuilder<CRAOfflineData, String?, QQueryOperations>
      languageCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'languageCode');
    });
  }

  QueryBuilder<CRAOfflineData, String?, QQueryOperations> patientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'patientId');
    });
  }

  QueryBuilder<CRAOfflineData, String?, QQueryOperations>
      versionNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionNumber');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CRASectionModelSchema = Schema(
  name: r'CRASectionModel',
  id: -2175305491937674867,
  properties: {
    r'ehrCategoryMap': PropertySchema(
      id: 0,
      name: r'ehrCategoryMap',
      type: IsarType.string,
    ),
    r'questionnaireList': PropertySchema(
      id: 1,
      name: r'questionnaireList',
      type: IsarType.objectList,
      target: r'CRAQuestionnaire',
    )
  },
  estimateSize: _cRASectionModelEstimateSize,
  serialize: _cRASectionModelSerialize,
  deserialize: _cRASectionModelDeserialize,
  deserializeProp: _cRASectionModelDeserializeProp,
);

int _cRASectionModelEstimateSize(
  CRASectionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.ehrCategoryMap;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.questionnaireList;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[CRAQuestionnaire]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              CRAQuestionnaireSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _cRASectionModelSerialize(
  CRASectionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ehrCategoryMap);
  writer.writeObjectList<CRAQuestionnaire>(
    offsets[1],
    allOffsets,
    CRAQuestionnaireSchema.serialize,
    object.questionnaireList,
  );
}

CRASectionModel _cRASectionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CRASectionModel();
  object.ehrCategoryMap = reader.readStringOrNull(offsets[0]);
  object.questionnaireList = reader.readObjectList<CRAQuestionnaire>(
    offsets[1],
    CRAQuestionnaireSchema.deserialize,
    allOffsets,
    CRAQuestionnaire(),
  );
  return object;
}

P _cRASectionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectList<CRAQuestionnaire>(
        offset,
        CRAQuestionnaireSchema.deserialize,
        allOffsets,
        CRAQuestionnaire(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CRASectionModelQueryFilter
    on QueryBuilder<CRASectionModel, CRASectionModel, QFilterCondition> {
  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      ehrCategoryMapIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ehrCategoryMap',
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      ehrCategoryMapIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ehrCategoryMap',
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      ehrCategoryMapEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ehrCategoryMap',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      ehrCategoryMapGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ehrCategoryMap',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      ehrCategoryMapLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ehrCategoryMap',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      ehrCategoryMapBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ehrCategoryMap',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      ehrCategoryMapStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ehrCategoryMap',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      ehrCategoryMapEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ehrCategoryMap',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      ehrCategoryMapContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ehrCategoryMap',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      ehrCategoryMapMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ehrCategoryMap',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      ehrCategoryMapIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ehrCategoryMap',
        value: '',
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      ehrCategoryMapIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ehrCategoryMap',
        value: '',
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      questionnaireListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'questionnaireList',
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      questionnaireListIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'questionnaireList',
      ));
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      questionnaireListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionnaireList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      questionnaireListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionnaireList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      questionnaireListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionnaireList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      questionnaireListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionnaireList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      questionnaireListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionnaireList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      questionnaireListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionnaireList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension CRASectionModelQueryObject
    on QueryBuilder<CRASectionModel, CRASectionModel, QFilterCondition> {
  QueryBuilder<CRASectionModel, CRASectionModel, QAfterFilterCondition>
      questionnaireListElement(FilterQuery<CRAQuestionnaire> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'questionnaireList');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CRAQuestionnaireSchema = Schema(
  name: r'CRAQuestionnaire',
  id: 5526173510903603092,
  properties: {
    r'inputs': PropertySchema(
      id: 0,
      name: r'inputs',
      type: IsarType.objectList,
      target: r'Inputs',
    ),
    r'lonic': PropertySchema(
      id: 1,
      name: r'lonic',
      type: IsarType.string,
    ),
    r'questionId': PropertySchema(
      id: 2,
      name: r'questionId',
      type: IsarType.string,
    ),
    r'snomed': PropertySchema(
      id: 3,
      name: r'snomed',
      type: IsarType.string,
    ),
    r'timeAsked': PropertySchema(
      id: 4,
      name: r'timeAsked',
      type: IsarType.dateTime,
    ),
    r'value': PropertySchema(
      id: 5,
      name: r'value',
      type: IsarType.string,
    ),
    r'versionNumber': PropertySchema(
      id: 6,
      name: r'versionNumber',
      type: IsarType.string,
    )
  },
  estimateSize: _cRAQuestionnaireEstimateSize,
  serialize: _cRAQuestionnaireSerialize,
  deserialize: _cRAQuestionnaireDeserialize,
  deserializeProp: _cRAQuestionnaireDeserializeProp,
);

int _cRAQuestionnaireEstimateSize(
  CRAQuestionnaire object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.inputs;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Inputs]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += InputsSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.lonic;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.questionId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.snomed;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.value;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.versionNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cRAQuestionnaireSerialize(
  CRAQuestionnaire object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<Inputs>(
    offsets[0],
    allOffsets,
    InputsSchema.serialize,
    object.inputs,
  );
  writer.writeString(offsets[1], object.lonic);
  writer.writeString(offsets[2], object.questionId);
  writer.writeString(offsets[3], object.snomed);
  writer.writeDateTime(offsets[4], object.timeAsked);
  writer.writeString(offsets[5], object.value);
  writer.writeString(offsets[6], object.versionNumber);
}

CRAQuestionnaire _cRAQuestionnaireDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CRAQuestionnaire();
  object.inputs = reader.readObjectList<Inputs>(
    offsets[0],
    InputsSchema.deserialize,
    allOffsets,
    Inputs(),
  );
  object.lonic = reader.readStringOrNull(offsets[1]);
  object.questionId = reader.readStringOrNull(offsets[2]);
  object.snomed = reader.readStringOrNull(offsets[3]);
  object.timeAsked = reader.readDateTimeOrNull(offsets[4]);
  object.value = reader.readStringOrNull(offsets[5]);
  object.versionNumber = reader.readStringOrNull(offsets[6]);
  return object;
}

P _cRAQuestionnaireDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<Inputs>(
        offset,
        InputsSchema.deserialize,
        allOffsets,
        Inputs(),
      )) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CRAQuestionnaireQueryFilter
    on QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QFilterCondition> {
  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      inputsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inputs',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      inputsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inputs',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      inputsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inputs',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      inputsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inputs',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      inputsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inputs',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      inputsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inputs',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      inputsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inputs',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      inputsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'inputs',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      lonicIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lonic',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      lonicIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lonic',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      lonicEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lonic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      lonicGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lonic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      lonicLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lonic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      lonicBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lonic',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      lonicStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lonic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      lonicEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lonic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      lonicContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lonic',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      lonicMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lonic',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      lonicIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lonic',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      lonicIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lonic',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      questionIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'questionId',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      questionIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'questionId',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      questionIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      questionIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      questionIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      questionIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      questionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      questionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      questionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      questionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      questionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionId',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      questionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questionId',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      snomedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'snomed',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      snomedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'snomed',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      snomedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      snomedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      snomedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      snomedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'snomed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      snomedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      snomedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      snomedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      snomedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'snomed',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      snomedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snomed',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      snomedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'snomed',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      timeAskedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeAsked',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      timeAskedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeAsked',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      timeAskedEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeAsked',
        value: value,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      timeAskedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeAsked',
        value: value,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      timeAskedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeAsked',
        value: value,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      timeAskedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeAsked',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      valueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      valueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      valueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      valueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      valueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      valueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      valueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      valueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      versionNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'versionNumber',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      versionNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'versionNumber',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      versionNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      versionNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      versionNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      versionNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'versionNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      versionNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      versionNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      versionNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      versionNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'versionNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      versionNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      versionNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'versionNumber',
        value: '',
      ));
    });
  }
}

extension CRAQuestionnaireQueryObject
    on QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QFilterCondition> {
  QueryBuilder<CRAQuestionnaire, CRAQuestionnaire, QAfterFilterCondition>
      inputsElement(FilterQuery<Inputs> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'inputs');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const InputsSchema = Schema(
  name: r'Inputs',
  id: 4529800121908068552,
  properties: {
    r'inputId': PropertySchema(
      id: 0,
      name: r'inputId',
      type: IsarType.string,
    ),
    r'inputsBranch': PropertySchema(
      id: 1,
      name: r'inputsBranch',
      type: IsarType.object,
      target: r'InputsBranch',
    ),
    r'loinc': PropertySchema(
      id: 2,
      name: r'loinc',
      type: IsarType.string,
    ),
    r'snomed': PropertySchema(
      id: 3,
      name: r'snomed',
      type: IsarType.string,
    ),
    r'timeAsked': PropertySchema(
      id: 4,
      name: r'timeAsked',
      type: IsarType.dateTime,
    ),
    r'value': PropertySchema(
      id: 5,
      name: r'value',
      type: IsarType.string,
    )
  },
  estimateSize: _inputsEstimateSize,
  serialize: _inputsSerialize,
  deserialize: _inputsDeserialize,
  deserializeProp: _inputsDeserializeProp,
);

int _inputsEstimateSize(
  Inputs object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.inputId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.inputsBranch;
    if (value != null) {
      bytesCount += 3 +
          InputsBranchSchema.estimateSize(
              value, allOffsets[InputsBranch]!, allOffsets);
    }
  }
  {
    final value = object.loinc;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.snomed;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.value;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _inputsSerialize(
  Inputs object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.inputId);
  writer.writeObject<InputsBranch>(
    offsets[1],
    allOffsets,
    InputsBranchSchema.serialize,
    object.inputsBranch,
  );
  writer.writeString(offsets[2], object.loinc);
  writer.writeString(offsets[3], object.snomed);
  writer.writeDateTime(offsets[4], object.timeAsked);
  writer.writeString(offsets[5], object.value);
}

Inputs _inputsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Inputs();
  object.inputId = reader.readStringOrNull(offsets[0]);
  object.inputsBranch = reader.readObjectOrNull<InputsBranch>(
    offsets[1],
    InputsBranchSchema.deserialize,
    allOffsets,
  );
  object.loinc = reader.readStringOrNull(offsets[2]);
  object.snomed = reader.readStringOrNull(offsets[3]);
  object.timeAsked = reader.readDateTimeOrNull(offsets[4]);
  object.value = reader.readStringOrNull(offsets[5]);
  return object;
}

P _inputsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<InputsBranch>(
        offset,
        InputsBranchSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension InputsQueryFilter on QueryBuilder<Inputs, Inputs, QFilterCondition> {
  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inputId',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inputId',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inputId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inputId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inputId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'inputId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'inputId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'inputId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'inputId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputId',
        value: '',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inputId',
        value: '',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputsBranchIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inputsBranch',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputsBranchIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inputsBranch',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> loincIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'loinc',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> loincIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'loinc',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> loincEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loinc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> loincGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loinc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> loincLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loinc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> loincBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loinc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> loincStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'loinc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> loincEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'loinc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> loincContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'loinc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> loincMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'loinc',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> loincIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loinc',
        value: '',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> loincIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'loinc',
        value: '',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> snomedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'snomed',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> snomedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'snomed',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> snomedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> snomedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> snomedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> snomedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'snomed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> snomedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> snomedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> snomedContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> snomedMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'snomed',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> snomedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snomed',
        value: '',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> snomedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'snomed',
        value: '',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> timeAskedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeAsked',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> timeAskedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeAsked',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> timeAskedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeAsked',
        value: value,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> timeAskedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeAsked',
        value: value,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> timeAskedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeAsked',
        value: value,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> timeAskedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeAsked',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> valueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> valueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> valueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> valueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> valueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> valueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> valueContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> valueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'value',
        value: '',
      ));
    });
  }
}

extension InputsQueryObject on QueryBuilder<Inputs, Inputs, QFilterCondition> {
  QueryBuilder<Inputs, Inputs, QAfterFilterCondition> inputsBranch(
      FilterQuery<InputsBranch> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'inputsBranch');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const InputsBranchSchema = Schema(
  name: r'InputsBranch',
  id: 6202409851886065768,
  properties: {
    r'inputId': PropertySchema(
      id: 0,
      name: r'inputId',
      type: IsarType.string,
    ),
    r'loinc': PropertySchema(
      id: 1,
      name: r'loinc',
      type: IsarType.string,
    ),
    r'snomed': PropertySchema(
      id: 2,
      name: r'snomed',
      type: IsarType.string,
    ),
    r'value': PropertySchema(
      id: 3,
      name: r'value',
      type: IsarType.string,
    )
  },
  estimateSize: _inputsBranchEstimateSize,
  serialize: _inputsBranchSerialize,
  deserialize: _inputsBranchDeserialize,
  deserializeProp: _inputsBranchDeserializeProp,
);

int _inputsBranchEstimateSize(
  InputsBranch object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.inputId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.loinc;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.snomed;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.value;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _inputsBranchSerialize(
  InputsBranch object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.inputId);
  writer.writeString(offsets[1], object.loinc);
  writer.writeString(offsets[2], object.snomed);
  writer.writeString(offsets[3], object.value);
}

InputsBranch _inputsBranchDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InputsBranch();
  object.inputId = reader.readStringOrNull(offsets[0]);
  object.loinc = reader.readStringOrNull(offsets[1]);
  object.snomed = reader.readStringOrNull(offsets[2]);
  object.value = reader.readStringOrNull(offsets[3]);
  return object;
}

P _inputsBranchDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension InputsBranchQueryFilter
    on QueryBuilder<InputsBranch, InputsBranch, QFilterCondition> {
  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      inputIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inputId',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      inputIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inputId',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      inputIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      inputIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inputId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      inputIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inputId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      inputIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inputId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      inputIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'inputId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      inputIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'inputId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      inputIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'inputId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      inputIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'inputId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      inputIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputId',
        value: '',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      inputIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inputId',
        value: '',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      loincIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'loinc',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      loincIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'loinc',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> loincEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loinc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      loincGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loinc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> loincLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loinc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> loincBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loinc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      loincStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'loinc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> loincEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'loinc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> loincContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'loinc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> loincMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'loinc',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      loincIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loinc',
        value: '',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      loincIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'loinc',
        value: '',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      snomedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'snomed',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      snomedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'snomed',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> snomedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      snomedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      snomedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> snomedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'snomed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      snomedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      snomedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      snomedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'snomed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> snomedMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'snomed',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      snomedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'snomed',
        value: '',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      snomedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'snomed',
        value: '',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      valueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      valueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'value',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> valueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      valueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> valueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> valueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> valueContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition> valueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<InputsBranch, InputsBranch, QAfterFilterCondition>
      valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'value',
        value: '',
      ));
    });
  }
}

extension InputsBranchQueryObject
    on QueryBuilder<InputsBranch, InputsBranch, QFilterCondition> {}
