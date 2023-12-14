// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_assessment_questionaire.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRiskAssessmentQuestionaireCollection on Isar {
  IsarCollection<RiskAssessmentQuestionaire> get riskAssessmentQuestionaires =>
      this.collection();
}

const RiskAssessmentQuestionaireSchema = CollectionSchema(
  name: r'RiskAssessmentQuestionaire',
  id: -6727376593895483744,
  properties: {
    r'locale': PropertySchema(
      id: 0,
      name: r'locale',
      type: IsarType.string,
    ),
    r'sections': PropertySchema(
      id: 1,
      name: r'sections',
      type: IsarType.objectList,
      target: r'QuestionnairesModel',
    )
  },
  estimateSize: _riskAssessmentQuestionaireEstimateSize,
  serialize: _riskAssessmentQuestionaireSerialize,
  deserialize: _riskAssessmentQuestionaireDeserialize,
  deserializeProp: _riskAssessmentQuestionaireDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'QuestionnairesModel': QuestionnairesModelSchema,
    r'QuestionObj': QuestionObjSchema,
    r'Option': OptionSchema,
    r'Followup': FollowupSchema
  },
  getId: _riskAssessmentQuestionaireGetId,
  getLinks: _riskAssessmentQuestionaireGetLinks,
  attach: _riskAssessmentQuestionaireAttach,
  version: '3.1.0+1',
);

int _riskAssessmentQuestionaireEstimateSize(
  RiskAssessmentQuestionaire object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.locale;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.sections;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[QuestionnairesModel]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += QuestionnairesModelSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _riskAssessmentQuestionaireSerialize(
  RiskAssessmentQuestionaire object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.locale);
  writer.writeObjectList<QuestionnairesModel>(
    offsets[1],
    allOffsets,
    QuestionnairesModelSchema.serialize,
    object.sections,
  );
}

RiskAssessmentQuestionaire _riskAssessmentQuestionaireDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RiskAssessmentQuestionaire();
  object.id = id;
  object.locale = reader.readStringOrNull(offsets[0]);
  object.sections = reader.readObjectList<QuestionnairesModel>(
    offsets[1],
    QuestionnairesModelSchema.deserialize,
    allOffsets,
    QuestionnairesModel(),
  );
  return object;
}

P _riskAssessmentQuestionaireDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectList<QuestionnairesModel>(
        offset,
        QuestionnairesModelSchema.deserialize,
        allOffsets,
        QuestionnairesModel(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _riskAssessmentQuestionaireGetId(RiskAssessmentQuestionaire object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _riskAssessmentQuestionaireGetLinks(
    RiskAssessmentQuestionaire object) {
  return [];
}

void _riskAssessmentQuestionaireAttach(
    IsarCollection<dynamic> col, Id id, RiskAssessmentQuestionaire object) {
  object.id = id;
}

extension RiskAssessmentQuestionaireQueryWhereSort on QueryBuilder<
    RiskAssessmentQuestionaire, RiskAssessmentQuestionaire, QWhere> {
  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RiskAssessmentQuestionaireQueryWhere on QueryBuilder<
    RiskAssessmentQuestionaire, RiskAssessmentQuestionaire, QWhereClause> {
  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterWhereClause> idBetween(
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

extension RiskAssessmentQuestionaireQueryFilter on QueryBuilder<
    RiskAssessmentQuestionaire, RiskAssessmentQuestionaire, QFilterCondition> {
  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
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

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
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

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
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

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> localeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locale',
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> localeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locale',
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> localeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> localeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> localeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> localeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locale',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> localeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> localeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
          QAfterFilterCondition>
      localeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
          QAfterFilterCondition>
      localeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locale',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> localeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locale',
        value: '',
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> localeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locale',
        value: '',
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> sectionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sections',
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> sectionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sections',
      ));
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> sectionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sections',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> sectionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sections',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> sectionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sections',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> sectionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sections',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> sectionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sections',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterFilterCondition> sectionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sections',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension RiskAssessmentQuestionaireQueryObject on QueryBuilder<
    RiskAssessmentQuestionaire, RiskAssessmentQuestionaire, QFilterCondition> {
  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
          QAfterFilterCondition>
      sectionsElement(FilterQuery<QuestionnairesModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sections');
    });
  }
}

extension RiskAssessmentQuestionaireQueryLinks on QueryBuilder<
    RiskAssessmentQuestionaire, RiskAssessmentQuestionaire, QFilterCondition> {}

extension RiskAssessmentQuestionaireQuerySortBy on QueryBuilder<
    RiskAssessmentQuestionaire, RiskAssessmentQuestionaire, QSortBy> {
  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterSortBy> sortByLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.asc);
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterSortBy> sortByLocaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.desc);
    });
  }
}

extension RiskAssessmentQuestionaireQuerySortThenBy on QueryBuilder<
    RiskAssessmentQuestionaire, RiskAssessmentQuestionaire, QSortThenBy> {
  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterSortBy> thenByLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.asc);
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QAfterSortBy> thenByLocaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.desc);
    });
  }
}

extension RiskAssessmentQuestionaireQueryWhereDistinct on QueryBuilder<
    RiskAssessmentQuestionaire, RiskAssessmentQuestionaire, QDistinct> {
  QueryBuilder<RiskAssessmentQuestionaire, RiskAssessmentQuestionaire,
      QDistinct> distinctByLocale({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locale', caseSensitive: caseSensitive);
    });
  }
}

extension RiskAssessmentQuestionaireQueryProperty on QueryBuilder<
    RiskAssessmentQuestionaire, RiskAssessmentQuestionaire, QQueryProperty> {
  QueryBuilder<RiskAssessmentQuestionaire, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, String?, QQueryOperations>
      localeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locale');
    });
  }

  QueryBuilder<RiskAssessmentQuestionaire, List<QuestionnairesModel>?,
      QQueryOperations> sectionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sections');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const QuestionnairesModelSchema = Schema(
  name: r'QuestionnairesModel',
  id: 1601973570860344599,
  properties: {
    r'firstQuestionId': PropertySchema(
      id: 0,
      name: r'firstQuestionId',
      type: IsarType.string,
    ),
    r'questionObj': PropertySchema(
      id: 1,
      name: r'questionObj',
      type: IsarType.objectList,
      target: r'QuestionObj',
    ),
    r'sectionName': PropertySchema(
      id: 2,
      name: r'sectionName',
      type: IsarType.string,
    ),
    r'templateName': PropertySchema(
      id: 3,
      name: r'templateName',
      type: IsarType.string,
    ),
    r'uiTemplateId': PropertySchema(
      id: 4,
      name: r'uiTemplateId',
      type: IsarType.string,
    ),
    r'versionNumber': PropertySchema(
      id: 5,
      name: r'versionNumber',
      type: IsarType.string,
    )
  },
  estimateSize: _questionnairesModelEstimateSize,
  serialize: _questionnairesModelSerialize,
  deserialize: _questionnairesModelDeserialize,
  deserializeProp: _questionnairesModelDeserializeProp,
);

int _questionnairesModelEstimateSize(
  QuestionnairesModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.firstQuestionId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.questionObj;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[QuestionObj]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              QuestionObjSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.sectionName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.templateName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.uiTemplateId;
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

void _questionnairesModelSerialize(
  QuestionnairesModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.firstQuestionId);
  writer.writeObjectList<QuestionObj>(
    offsets[1],
    allOffsets,
    QuestionObjSchema.serialize,
    object.questionObj,
  );
  writer.writeString(offsets[2], object.sectionName);
  writer.writeString(offsets[3], object.templateName);
  writer.writeString(offsets[4], object.uiTemplateId);
  writer.writeString(offsets[5], object.versionNumber);
}

QuestionnairesModel _questionnairesModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestionnairesModel();
  object.firstQuestionId = reader.readStringOrNull(offsets[0]);
  object.questionObj = reader.readObjectList<QuestionObj>(
    offsets[1],
    QuestionObjSchema.deserialize,
    allOffsets,
    QuestionObj(),
  );
  object.sectionName = reader.readStringOrNull(offsets[2]);
  object.templateName = reader.readStringOrNull(offsets[3]);
  object.uiTemplateId = reader.readStringOrNull(offsets[4]);
  object.versionNumber = reader.readStringOrNull(offsets[5]);
  return object;
}

P _questionnairesModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectList<QuestionObj>(
        offset,
        QuestionObjSchema.deserialize,
        allOffsets,
        QuestionObj(),
      )) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension QuestionnairesModelQueryFilter on QueryBuilder<QuestionnairesModel,
    QuestionnairesModel, QFilterCondition> {
  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      firstQuestionIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firstQuestionId',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      firstQuestionIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firstQuestionId',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      firstQuestionIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      firstQuestionIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      firstQuestionIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      firstQuestionIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstQuestionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      firstQuestionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firstQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      firstQuestionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firstQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      firstQuestionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firstQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      firstQuestionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firstQuestionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      firstQuestionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstQuestionId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      firstQuestionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firstQuestionId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      questionObjIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'questionObj',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      questionObjIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'questionObj',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      questionObjLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionObj',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      questionObjIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionObj',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      questionObjIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionObj',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      questionObjLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionObj',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      questionObjLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionObj',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      questionObjLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'questionObj',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      sectionNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sectionName',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      sectionNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sectionName',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      sectionNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sectionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      sectionNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sectionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      sectionNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sectionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      sectionNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sectionName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      sectionNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sectionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      sectionNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sectionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      sectionNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sectionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      sectionNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sectionName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      sectionNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sectionName',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      sectionNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sectionName',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      templateNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'templateName',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      templateNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'templateName',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      templateNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'templateName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      templateNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'templateName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      templateNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'templateName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      templateNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'templateName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      templateNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'templateName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      templateNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'templateName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      templateNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'templateName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      templateNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'templateName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      templateNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'templateName',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      templateNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'templateName',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      uiTemplateIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uiTemplateId',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      uiTemplateIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uiTemplateId',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      uiTemplateIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uiTemplateId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      uiTemplateIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uiTemplateId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      uiTemplateIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uiTemplateId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      uiTemplateIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uiTemplateId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      uiTemplateIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uiTemplateId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      uiTemplateIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uiTemplateId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      uiTemplateIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uiTemplateId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      uiTemplateIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uiTemplateId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      uiTemplateIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uiTemplateId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      uiTemplateIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uiTemplateId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      versionNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'versionNumber',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      versionNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'versionNumber',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
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

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
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

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
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

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
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

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
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

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
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

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      versionNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'versionNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      versionNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'versionNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      versionNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      versionNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'versionNumber',
        value: '',
      ));
    });
  }
}

extension QuestionnairesModelQueryObject on QueryBuilder<QuestionnairesModel,
    QuestionnairesModel, QFilterCondition> {
  QueryBuilder<QuestionnairesModel, QuestionnairesModel, QAfterFilterCondition>
      questionObjElement(FilterQuery<QuestionObj> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'questionObj');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const QuestionObjSchema = Schema(
  name: r'QuestionObj',
  id: -7339455760347220557,
  properties: {
    r'filter': PropertySchema(
      id: 0,
      name: r'filter',
      type: IsarType.string,
    ),
    r'followup': PropertySchema(
      id: 1,
      name: r'followup',
      type: IsarType.objectList,
      target: r'Followup',
    ),
    r'hintText': PropertySchema(
      id: 2,
      name: r'hintText',
      type: IsarType.string,
    ),
    r'lastQuestion': PropertySchema(
      id: 3,
      name: r'lastQuestion',
      type: IsarType.bool,
    ),
    r'maxValidator': PropertySchema(
      id: 4,
      name: r'maxValidator',
      type: IsarType.long,
    ),
    r'minvalidator': PropertySchema(
      id: 5,
      name: r'minvalidator',
      type: IsarType.long,
    ),
    r'nextQuestionId': PropertySchema(
      id: 6,
      name: r'nextQuestionId',
      type: IsarType.string,
    ),
    r'options': PropertySchema(
      id: 7,
      name: r'options',
      type: IsarType.objectList,
      target: r'Option',
    ),
    r'placeholder': PropertySchema(
      id: 8,
      name: r'placeholder',
      type: IsarType.string,
    ),
    r'prevQuestionId': PropertySchema(
      id: 9,
      name: r'prevQuestionId',
      type: IsarType.string,
    ),
    r'questionId': PropertySchema(
      id: 10,
      name: r'questionId',
      type: IsarType.string,
    ),
    r'questionText': PropertySchema(
      id: 11,
      name: r'questionText',
      type: IsarType.string,
    ),
    r'regex': PropertySchema(
      id: 12,
      name: r'regex',
      type: IsarType.string,
    ),
    r'requiredValue': PropertySchema(
      id: 13,
      name: r'requiredValue',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 14,
      name: r'type',
      type: IsarType.string,
    ),
    r'validationMessage': PropertySchema(
      id: 15,
      name: r'validationMessage',
      type: IsarType.string,
    )
  },
  estimateSize: _questionObjEstimateSize,
  serialize: _questionObjSerialize,
  deserialize: _questionObjDeserialize,
  deserializeProp: _questionObjDeserializeProp,
);

int _questionObjEstimateSize(
  QuestionObj object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.filter;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.followup;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Followup]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += FollowupSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.hintText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nextQuestionId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.options;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Option]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += OptionSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.placeholder;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.prevQuestionId;
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
    final value = object.questionText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.regex;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.requiredValue;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.validationMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _questionObjSerialize(
  QuestionObj object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.filter);
  writer.writeObjectList<Followup>(
    offsets[1],
    allOffsets,
    FollowupSchema.serialize,
    object.followup,
  );
  writer.writeString(offsets[2], object.hintText);
  writer.writeBool(offsets[3], object.lastQuestion);
  writer.writeLong(offsets[4], object.maxValidator);
  writer.writeLong(offsets[5], object.minvalidator);
  writer.writeString(offsets[6], object.nextQuestionId);
  writer.writeObjectList<Option>(
    offsets[7],
    allOffsets,
    OptionSchema.serialize,
    object.options,
  );
  writer.writeString(offsets[8], object.placeholder);
  writer.writeString(offsets[9], object.prevQuestionId);
  writer.writeString(offsets[10], object.questionId);
  writer.writeString(offsets[11], object.questionText);
  writer.writeString(offsets[12], object.regex);
  writer.writeString(offsets[13], object.requiredValue);
  writer.writeString(offsets[14], object.type);
  writer.writeString(offsets[15], object.validationMessage);
}

QuestionObj _questionObjDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestionObj();
  object.filter = reader.readStringOrNull(offsets[0]);
  object.followup = reader.readObjectList<Followup>(
    offsets[1],
    FollowupSchema.deserialize,
    allOffsets,
    Followup(),
  );
  object.hintText = reader.readStringOrNull(offsets[2]);
  object.lastQuestion = reader.readBoolOrNull(offsets[3]);
  object.maxValidator = reader.readLongOrNull(offsets[4]);
  object.minvalidator = reader.readLongOrNull(offsets[5]);
  object.nextQuestionId = reader.readStringOrNull(offsets[6]);
  object.options = reader.readObjectList<Option>(
    offsets[7],
    OptionSchema.deserialize,
    allOffsets,
    Option(),
  );
  object.placeholder = reader.readStringOrNull(offsets[8]);
  object.prevQuestionId = reader.readStringOrNull(offsets[9]);
  object.questionId = reader.readStringOrNull(offsets[10]);
  object.questionText = reader.readStringOrNull(offsets[11]);
  object.regex = reader.readStringOrNull(offsets[12]);
  object.requiredValue = reader.readStringOrNull(offsets[13]);
  object.type = reader.readStringOrNull(offsets[14]);
  object.validationMessage = reader.readStringOrNull(offsets[15]);
  return object;
}

P _questionObjDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readObjectList<Followup>(
        offset,
        FollowupSchema.deserialize,
        allOffsets,
        Followup(),
      )) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readObjectList<Option>(
        offset,
        OptionSchema.deserialize,
        allOffsets,
        Option(),
      )) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension QuestionObjQueryFilter
    on QueryBuilder<QuestionObj, QuestionObj, QFilterCondition> {
  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> filterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'filter',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      filterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'filter',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> filterEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'filter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      filterGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'filter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> filterLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'filter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> filterBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'filter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      filterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'filter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> filterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'filter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> filterContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'filter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> filterMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'filter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      filterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'filter',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      filterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'filter',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      followupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'followup',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      followupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'followup',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      followupLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'followup',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      followupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'followup',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      followupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'followup',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      followupLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'followup',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      followupLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'followup',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      followupLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'followup',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      hintTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hintText',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      hintTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hintText',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> hintTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hintText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      hintTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hintText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      hintTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hintText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> hintTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hintText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      hintTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hintText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      hintTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hintText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      hintTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hintText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> hintTextMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hintText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      hintTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hintText',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      hintTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hintText',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      lastQuestionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastQuestion',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      lastQuestionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastQuestion',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      lastQuestionEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastQuestion',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      maxValidatorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxValidator',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      maxValidatorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxValidator',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      maxValidatorEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxValidator',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      maxValidatorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxValidator',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      maxValidatorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxValidator',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      maxValidatorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxValidator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      minvalidatorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minvalidator',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      minvalidatorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minvalidator',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      minvalidatorEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minvalidator',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      minvalidatorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minvalidator',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      minvalidatorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minvalidator',
        value: value,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      minvalidatorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minvalidator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      nextQuestionIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextQuestionId',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      nextQuestionIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextQuestionId',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      nextQuestionIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      nextQuestionIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      nextQuestionIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      nextQuestionIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextQuestionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      nextQuestionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nextQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      nextQuestionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nextQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      nextQuestionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nextQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      nextQuestionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nextQuestionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      nextQuestionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextQuestionId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      nextQuestionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nextQuestionId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      optionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'options',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      optionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'options',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      optionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      optionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      optionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      optionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      optionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      optionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      placeholderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'placeholder',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      placeholderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'placeholder',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      placeholderEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'placeholder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      placeholderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'placeholder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      placeholderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'placeholder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      placeholderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'placeholder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      placeholderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'placeholder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      placeholderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'placeholder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      placeholderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'placeholder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      placeholderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'placeholder',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      placeholderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'placeholder',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      placeholderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'placeholder',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      prevQuestionIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'prevQuestionId',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      prevQuestionIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'prevQuestionId',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      prevQuestionIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prevQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      prevQuestionIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prevQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      prevQuestionIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prevQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      prevQuestionIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prevQuestionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      prevQuestionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'prevQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      prevQuestionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'prevQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      prevQuestionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'prevQuestionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      prevQuestionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'prevQuestionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      prevQuestionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prevQuestionId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      prevQuestionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'prevQuestionId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'questionId',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'questionId',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
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

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
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

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
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

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
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

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
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

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
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

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questionId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'questionText',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'questionText',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questionText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionText',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      questionTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questionText',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> regexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'regex',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      regexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'regex',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> regexEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'regex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      regexGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'regex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> regexLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'regex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> regexBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'regex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> regexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'regex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> regexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'regex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> regexContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'regex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> regexMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'regex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> regexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'regex',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      regexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'regex',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      requiredValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requiredValue',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      requiredValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requiredValue',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      requiredValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requiredValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      requiredValueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'requiredValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      requiredValueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'requiredValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      requiredValueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'requiredValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      requiredValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'requiredValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      requiredValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'requiredValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      requiredValueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'requiredValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      requiredValueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'requiredValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      requiredValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requiredValue',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      requiredValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'requiredValue',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> typeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> typeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> typeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> typeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      validationMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'validationMessage',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      validationMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'validationMessage',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      validationMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'validationMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      validationMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'validationMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      validationMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'validationMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      validationMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'validationMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      validationMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'validationMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      validationMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'validationMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      validationMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'validationMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      validationMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'validationMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      validationMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'validationMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition>
      validationMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'validationMessage',
        value: '',
      ));
    });
  }
}

extension QuestionObjQueryObject
    on QueryBuilder<QuestionObj, QuestionObj, QFilterCondition> {
  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> followupElement(
      FilterQuery<Followup> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'followup');
    });
  }

  QueryBuilder<QuestionObj, QuestionObj, QAfterFilterCondition> optionsElement(
      FilterQuery<Option> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'options');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FollowupSchema = Schema(
  name: r'Followup',
  id: 5910151413166778107,
  properties: {
    r'followup': PropertySchema(
      id: 0,
      name: r'followup',
      type: IsarType.objectList,
      target: r'Followup',
    ),
    r'forOptionKey': PropertySchema(
      id: 1,
      name: r'forOptionKey',
      type: IsarType.string,
    ),
    r'inputId': PropertySchema(
      id: 2,
      name: r'inputId',
      type: IsarType.string,
    ),
    r'inputText': PropertySchema(
      id: 3,
      name: r'inputText',
      type: IsarType.string,
    ),
    r'maxValidator': PropertySchema(
      id: 4,
      name: r'maxValidator',
      type: IsarType.string,
    ),
    r'minValidator': PropertySchema(
      id: 5,
      name: r'minValidator',
      type: IsarType.string,
    ),
    r'options': PropertySchema(
      id: 6,
      name: r'options',
      type: IsarType.objectList,
      target: r'Option',
    ),
    r'placeholder': PropertySchema(
      id: 7,
      name: r'placeholder',
      type: IsarType.string,
    ),
    r'rangeValidator': PropertySchema(
      id: 8,
      name: r'rangeValidator',
      type: IsarType.string,
    ),
    r'regex': PropertySchema(
      id: 9,
      name: r'regex',
      type: IsarType.string,
    ),
    r'requiredValue': PropertySchema(
      id: 10,
      name: r'requiredValue',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 11,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _followupEstimateSize,
  serialize: _followupSerialize,
  deserialize: _followupDeserialize,
  deserializeProp: _followupDeserializeProp,
);

int _followupEstimateSize(
  Followup object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.followup;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Followup]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += FollowupSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.forOptionKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.inputId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.inputText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.maxValidator;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.minValidator;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.options;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Option]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += OptionSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.placeholder;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.rangeValidator;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.regex;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.requiredValue;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _followupSerialize(
  Followup object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<Followup>(
    offsets[0],
    allOffsets,
    FollowupSchema.serialize,
    object.followup,
  );
  writer.writeString(offsets[1], object.forOptionKey);
  writer.writeString(offsets[2], object.inputId);
  writer.writeString(offsets[3], object.inputText);
  writer.writeString(offsets[4], object.maxValidator);
  writer.writeString(offsets[5], object.minValidator);
  writer.writeObjectList<Option>(
    offsets[6],
    allOffsets,
    OptionSchema.serialize,
    object.options,
  );
  writer.writeString(offsets[7], object.placeholder);
  writer.writeString(offsets[8], object.rangeValidator);
  writer.writeString(offsets[9], object.regex);
  writer.writeString(offsets[10], object.requiredValue);
  writer.writeString(offsets[11], object.type);
}

Followup _followupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Followup();
  object.followup = reader.readObjectList<Followup>(
    offsets[0],
    FollowupSchema.deserialize,
    allOffsets,
    Followup(),
  );
  object.forOptionKey = reader.readStringOrNull(offsets[1]);
  object.inputId = reader.readStringOrNull(offsets[2]);
  object.inputText = reader.readStringOrNull(offsets[3]);
  object.maxValidator = reader.readStringOrNull(offsets[4]);
  object.minValidator = reader.readStringOrNull(offsets[5]);
  object.options = reader.readObjectList<Option>(
    offsets[6],
    OptionSchema.deserialize,
    allOffsets,
    Option(),
  );
  object.placeholder = reader.readStringOrNull(offsets[7]);
  object.rangeValidator = reader.readStringOrNull(offsets[8]);
  object.regex = reader.readStringOrNull(offsets[9]);
  object.requiredValue = reader.readStringOrNull(offsets[10]);
  object.type = reader.readStringOrNull(offsets[11]);
  return object;
}

P _followupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<Followup>(
        offset,
        FollowupSchema.deserialize,
        allOffsets,
        Followup(),
      )) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readObjectList<Option>(
        offset,
        OptionSchema.deserialize,
        allOffsets,
        Option(),
      )) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FollowupQueryFilter
    on QueryBuilder<Followup, Followup, QFilterCondition> {
  QueryBuilder<Followup, Followup, QAfterFilterCondition> followupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'followup',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> followupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'followup',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> followupLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'followup',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> followupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'followup',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> followupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'followup',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      followupLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'followup',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      followupLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'followup',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> followupLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'followup',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> forOptionKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'forOptionKey',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      forOptionKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'forOptionKey',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> forOptionKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'forOptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      forOptionKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'forOptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> forOptionKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'forOptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> forOptionKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'forOptionKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      forOptionKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'forOptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> forOptionKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'forOptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> forOptionKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'forOptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> forOptionKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'forOptionKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      forOptionKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'forOptionKey',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      forOptionKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'forOptionKey',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inputId',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inputId',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputIdEqualTo(
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

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputIdGreaterThan(
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

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputIdLessThan(
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

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputIdBetween(
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

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputIdStartsWith(
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

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputIdEndsWith(
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

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputIdContains(
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

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputIdMatches(
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

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputId',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inputId',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'inputText',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'inputText',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inputText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inputText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inputText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'inputText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'inputText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputTextContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'inputText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputTextMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'inputText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> inputTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inputText',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      inputTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inputText',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> maxValidatorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxValidator',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      maxValidatorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxValidator',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> maxValidatorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      maxValidatorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> maxValidatorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> maxValidatorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxValidator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      maxValidatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'maxValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> maxValidatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'maxValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> maxValidatorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'maxValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> maxValidatorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'maxValidator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      maxValidatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxValidator',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      maxValidatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'maxValidator',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> minValidatorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minValidator',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      minValidatorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minValidator',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> minValidatorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      minValidatorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> minValidatorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> minValidatorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minValidator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      minValidatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'minValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> minValidatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'minValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> minValidatorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'minValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> minValidatorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'minValidator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      minValidatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minValidator',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      minValidatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'minValidator',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> optionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'options',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> optionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'options',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> optionsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> optionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> optionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> optionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      optionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> optionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> placeholderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'placeholder',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      placeholderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'placeholder',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> placeholderEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'placeholder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      placeholderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'placeholder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> placeholderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'placeholder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> placeholderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'placeholder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> placeholderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'placeholder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> placeholderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'placeholder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> placeholderContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'placeholder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> placeholderMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'placeholder',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> placeholderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'placeholder',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      placeholderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'placeholder',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      rangeValidatorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rangeValidator',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      rangeValidatorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rangeValidator',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> rangeValidatorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rangeValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      rangeValidatorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rangeValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      rangeValidatorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rangeValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> rangeValidatorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rangeValidator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      rangeValidatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rangeValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      rangeValidatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rangeValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      rangeValidatorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rangeValidator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> rangeValidatorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rangeValidator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      rangeValidatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rangeValidator',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      rangeValidatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rangeValidator',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> regexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'regex',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> regexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'regex',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> regexEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'regex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> regexGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'regex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> regexLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'regex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> regexBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'regex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> regexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'regex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> regexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'regex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> regexContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'regex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> regexMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'regex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> regexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'regex',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> regexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'regex',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      requiredValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requiredValue',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      requiredValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requiredValue',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> requiredValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requiredValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      requiredValueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'requiredValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> requiredValueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'requiredValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> requiredValueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'requiredValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      requiredValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'requiredValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> requiredValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'requiredValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> requiredValueContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'requiredValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> requiredValueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'requiredValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      requiredValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requiredValue',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition>
      requiredValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'requiredValue',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> typeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> typeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> typeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> typeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension FollowupQueryObject
    on QueryBuilder<Followup, Followup, QFilterCondition> {
  QueryBuilder<Followup, Followup, QAfterFilterCondition> followupElement(
      FilterQuery<Followup> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'followup');
    });
  }

  QueryBuilder<Followup, Followup, QAfterFilterCondition> optionsElement(
      FilterQuery<Option> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'options');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const OptionSchema = Schema(
  name: r'Option',
  id: -5786321349724631965,
  properties: {
    r'displayText': PropertySchema(
      id: 0,
      name: r'displayText',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    )
  },
  estimateSize: _optionEstimateSize,
  serialize: _optionSerialize,
  deserialize: _optionDeserialize,
  deserializeProp: _optionDeserializeProp,
);

int _optionEstimateSize(
  Option object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.displayText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _optionSerialize(
  Option object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.displayText);
  writer.writeString(offsets[1], object.id);
}

Option _optionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Option();
  object.displayText = reader.readStringOrNull(offsets[0]);
  object.id = reader.readStringOrNull(offsets[1]);
  return object;
}

P _optionDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension OptionQueryFilter on QueryBuilder<Option, Option, QFilterCondition> {
  QueryBuilder<Option, Option, QAfterFilterCondition> displayTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'displayText',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> displayTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'displayText',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> displayTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> displayTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> displayTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> displayTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> displayTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> displayTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> displayTextContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> displayTextMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> displayTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayText',
        value: '',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> displayTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayText',
        value: '',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }
}

extension OptionQueryObject on QueryBuilder<Option, Option, QFilterCondition> {}
