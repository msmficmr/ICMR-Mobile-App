// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_registration_schema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPatientRegistrationCollection on Isar {
  IsarCollection<PatientRegistration> get patientRegistrations =>
      this.collection();
}

const PatientRegistrationSchema = CollectionSchema(
  name: r'PatientRegistration',
  id: -9053874229062588828,
  properties: {
    r'aadharId': PropertySchema(
      id: 0,
      name: r'aadharId',
      type: IsarType.string,
    ),
    r'address': PropertySchema(
      id: 1,
      name: r'address',
      type: IsarType.string,
    ),
    r'age': PropertySchema(
      id: 2,
      name: r'age',
      type: IsarType.string,
    ),
    r'alternatePhoneNumber': PropertySchema(
      id: 3,
      name: r'alternatePhoneNumber',
      type: IsarType.string,
    ),
    r'consent': PropertySchema(
      id: 4,
      name: r'consent',
      type: IsarType.objectList,
      target: r'AttachmentDb',
    ),
    r'consentDate': PropertySchema(
      id: 5,
      name: r'consentDate',
      type: IsarType.dateTime,
    ),
    r'createdBy': PropertySchema(
      id: 6,
      name: r'createdBy',
      type: IsarType.string,
    ),
    r'district': PropertySchema(
      id: 7,
      name: r'district',
      type: IsarType.string,
    ),
    r'firstName': PropertySchema(
      id: 8,
      name: r'firstName',
      type: IsarType.string,
    ),
    r'gender': PropertySchema(
      id: 9,
      name: r'gender',
      type: IsarType.string,
    ),
    r'institutionCodeID': PropertySchema(
      id: 10,
      name: r'institutionCodeID',
      type: IsarType.string,
    ),
    r'lastName': PropertySchema(
      id: 11,
      name: r'lastName',
      type: IsarType.string,
    ),
    r'medicalRecordNumber': PropertySchema(
      id: 12,
      name: r'medicalRecordNumber',
      type: IsarType.string,
    ),
    r'occupation': PropertySchema(
      id: 13,
      name: r'occupation',
      type: IsarType.string,
    ),
    r'patientId': PropertySchema(
      id: 14,
      name: r'patientId',
      type: IsarType.string,
    ),
    r'permanentAddress': PropertySchema(
      id: 15,
      name: r'permanentAddress',
      type: IsarType.string,
    ),
    r'phoneNumber': PropertySchema(
      id: 16,
      name: r'phoneNumber',
      type: IsarType.string,
    ),
    r'pincode': PropertySchema(
      id: 17,
      name: r'pincode',
      type: IsarType.string,
    ),
    r'signedConsent': PropertySchema(
      id: 18,
      name: r'signedConsent',
      type: IsarType.string,
    ),
    r'signedConsentNoReason': PropertySchema(
      id: 19,
      name: r'signedConsentNoReason',
      type: IsarType.string,
    ),
    r'state': PropertySchema(
      id: 20,
      name: r'state',
      type: IsarType.string,
    ),
    r'studyCode': PropertySchema(
      id: 21,
      name: r'studyCode',
      type: IsarType.string,
    ),
    r'visitDate': PropertySchema(
      id: 22,
      name: r'visitDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _patientRegistrationEstimateSize,
  serialize: _patientRegistrationSerialize,
  deserialize: _patientRegistrationDeserialize,
  deserializeProp: _patientRegistrationDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'AttachmentDb': AttachmentDbSchema},
  getId: _patientRegistrationGetId,
  getLinks: _patientRegistrationGetLinks,
  attach: _patientRegistrationAttach,
  version: '3.1.0+1',
);

int _patientRegistrationEstimateSize(
  PatientRegistration object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.aadharId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.address;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.age.length * 3;
  {
    final value = object.alternatePhoneNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.consent;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[AttachmentDb]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              AttachmentDbSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.createdBy.length * 3;
  {
    final value = object.district;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.firstName.length * 3;
  {
    final value = object.gender;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.institutionCodeID.length * 3;
  bytesCount += 3 + object.lastName.length * 3;
  {
    final value = object.medicalRecordNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.occupation.length * 3;
  bytesCount += 3 + object.patientId.length * 3;
  {
    final value = object.permanentAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.phoneNumber.length * 3;
  {
    final value = object.pincode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.signedConsent.length * 3;
  bytesCount += 3 + object.signedConsentNoReason.length * 3;
  {
    final value = object.state;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.studyCode.length * 3;
  return bytesCount;
}

void _patientRegistrationSerialize(
  PatientRegistration object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aadharId);
  writer.writeString(offsets[1], object.address);
  writer.writeString(offsets[2], object.age);
  writer.writeString(offsets[3], object.alternatePhoneNumber);
  writer.writeObjectList<AttachmentDb>(
    offsets[4],
    allOffsets,
    AttachmentDbSchema.serialize,
    object.consent,
  );
  writer.writeDateTime(offsets[5], object.consentDate);
  writer.writeString(offsets[6], object.createdBy);
  writer.writeString(offsets[7], object.district);
  writer.writeString(offsets[8], object.firstName);
  writer.writeString(offsets[9], object.gender);
  writer.writeString(offsets[10], object.institutionCodeID);
  writer.writeString(offsets[11], object.lastName);
  writer.writeString(offsets[12], object.medicalRecordNumber);
  writer.writeString(offsets[13], object.occupation);
  writer.writeString(offsets[14], object.patientId);
  writer.writeString(offsets[15], object.permanentAddress);
  writer.writeString(offsets[16], object.phoneNumber);
  writer.writeString(offsets[17], object.pincode);
  writer.writeString(offsets[18], object.signedConsent);
  writer.writeString(offsets[19], object.signedConsentNoReason);
  writer.writeString(offsets[20], object.state);
  writer.writeString(offsets[21], object.studyCode);
  writer.writeDateTime(offsets[22], object.visitDate);
}

PatientRegistration _patientRegistrationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PatientRegistration();
  object.aadharId = reader.readStringOrNull(offsets[0]);
  object.address = reader.readStringOrNull(offsets[1]);
  object.age = reader.readString(offsets[2]);
  object.alternatePhoneNumber = reader.readStringOrNull(offsets[3]);
  object.consent = reader.readObjectList<AttachmentDb>(
    offsets[4],
    AttachmentDbSchema.deserialize,
    allOffsets,
    AttachmentDb(),
  );
  object.consentDate = reader.readDateTime(offsets[5]);
  object.createdBy = reader.readString(offsets[6]);
  object.district = reader.readStringOrNull(offsets[7]);
  object.firstName = reader.readString(offsets[8]);
  object.gender = reader.readStringOrNull(offsets[9]);
  object.id = id;
  object.institutionCodeID = reader.readString(offsets[10]);
  object.lastName = reader.readString(offsets[11]);
  object.medicalRecordNumber = reader.readStringOrNull(offsets[12]);
  object.occupation = reader.readString(offsets[13]);
  object.patientId = reader.readString(offsets[14]);
  object.permanentAddress = reader.readStringOrNull(offsets[15]);
  object.phoneNumber = reader.readString(offsets[16]);
  object.pincode = reader.readStringOrNull(offsets[17]);
  object.signedConsent = reader.readString(offsets[18]);
  object.signedConsentNoReason = reader.readString(offsets[19]);
  object.state = reader.readStringOrNull(offsets[20]);
  object.studyCode = reader.readString(offsets[21]);
  object.visitDate = reader.readDateTime(offsets[22]);
  return object;
}

P _patientRegistrationDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readObjectList<AttachmentDb>(
        offset,
        AttachmentDbSchema.deserialize,
        allOffsets,
        AttachmentDb(),
      )) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _patientRegistrationGetId(PatientRegistration object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _patientRegistrationGetLinks(
    PatientRegistration object) {
  return [];
}

void _patientRegistrationAttach(
    IsarCollection<dynamic> col, Id id, PatientRegistration object) {
  object.id = id;
}

extension PatientRegistrationQueryWhereSort
    on QueryBuilder<PatientRegistration, PatientRegistration, QWhere> {
  QueryBuilder<PatientRegistration, PatientRegistration, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PatientRegistrationQueryWhere
    on QueryBuilder<PatientRegistration, PatientRegistration, QWhereClause> {
  QueryBuilder<PatientRegistration, PatientRegistration, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterWhereClause>
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

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterWhereClause>
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
}

extension PatientRegistrationQueryFilter on QueryBuilder<PatientRegistration,
    PatientRegistration, QFilterCondition> {
  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      aadharIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aadharId',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      aadharIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aadharId',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      aadharIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aadharId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      aadharIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aadharId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      aadharIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aadharId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      aadharIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aadharId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      aadharIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aadharId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      aadharIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aadharId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      aadharIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aadharId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      aadharIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aadharId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      aadharIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aadharId',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      aadharIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aadharId',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      addressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      addressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      addressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      addressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      addressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      addressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      ageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'age',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      ageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'age',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      ageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'age',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      ageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'age',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      ageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'age',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      ageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'age',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      ageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'age',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      ageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'age',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      ageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'age',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      ageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'age',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      alternatePhoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'alternatePhoneNumber',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      alternatePhoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'alternatePhoneNumber',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      alternatePhoneNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alternatePhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      alternatePhoneNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'alternatePhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      alternatePhoneNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'alternatePhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      alternatePhoneNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'alternatePhoneNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      alternatePhoneNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'alternatePhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      alternatePhoneNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'alternatePhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      alternatePhoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'alternatePhoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      alternatePhoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'alternatePhoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      alternatePhoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'alternatePhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      alternatePhoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'alternatePhoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'consent',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'consent',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'consent',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'consent',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'consent',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'consent',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'consent',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'consent',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'consentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'consentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'consentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'consentDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      createdByEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      createdByGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      createdByLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      createdByBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      createdByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      createdByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      createdByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      createdByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      createdByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdBy',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      createdByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdBy',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      districtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'district',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      districtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'district',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      districtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'district',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      districtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'district',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      districtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'district',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      districtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'district',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      districtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'district',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      districtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'district',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      districtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'district',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      districtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'district',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      districtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'district',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      districtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'district',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      firstNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      firstNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      firstNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      firstNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      firstNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      firstNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      firstNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firstName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      firstNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firstName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      firstNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      firstNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firstName',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      genderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gender',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      genderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gender',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      genderEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      genderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      genderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      genderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      genderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      genderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      genderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      genderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gender',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      genderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      genderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
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

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
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

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      institutionCodeIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'institutionCodeID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      institutionCodeIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'institutionCodeID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      institutionCodeIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'institutionCodeID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      institutionCodeIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'institutionCodeID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      institutionCodeIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'institutionCodeID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      institutionCodeIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'institutionCodeID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      institutionCodeIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'institutionCodeID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      institutionCodeIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'institutionCodeID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      institutionCodeIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'institutionCodeID',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      institutionCodeIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'institutionCodeID',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      lastNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      lastNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      lastNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      lastNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      lastNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      lastNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      lastNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      lastNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      lastNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      lastNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastName',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      medicalRecordNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'medicalRecordNumber',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      medicalRecordNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'medicalRecordNumber',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      medicalRecordNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'medicalRecordNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      medicalRecordNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'medicalRecordNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      medicalRecordNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'medicalRecordNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      medicalRecordNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'medicalRecordNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      medicalRecordNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'medicalRecordNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      medicalRecordNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'medicalRecordNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      medicalRecordNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'medicalRecordNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      medicalRecordNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'medicalRecordNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      medicalRecordNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'medicalRecordNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      medicalRecordNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'medicalRecordNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      occupationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'occupation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      occupationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'occupation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      occupationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'occupation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      occupationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'occupation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      occupationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'occupation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      occupationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'occupation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      occupationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'occupation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      occupationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'occupation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      occupationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'occupation',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      occupationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'occupation',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      patientIdEqualTo(
    String value, {
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

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      patientIdGreaterThan(
    String value, {
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

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      patientIdLessThan(
    String value, {
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

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      patientIdBetween(
    String lower,
    String upper, {
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

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
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

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
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

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      patientIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'patientId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      patientIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'patientId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      patientIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'patientId',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      patientIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'patientId',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      permanentAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'permanentAddress',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      permanentAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'permanentAddress',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      permanentAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'permanentAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      permanentAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'permanentAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      permanentAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'permanentAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      permanentAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'permanentAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      permanentAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'permanentAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      permanentAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'permanentAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      permanentAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'permanentAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      permanentAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'permanentAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      permanentAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'permanentAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      permanentAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'permanentAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      phoneNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      phoneNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      phoneNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      phoneNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phoneNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      phoneNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      phoneNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      phoneNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phoneNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      phoneNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phoneNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      phoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      phoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phoneNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      pincodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pincode',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      pincodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pincode',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      pincodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pincode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      pincodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pincode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      pincodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pincode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      pincodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pincode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      pincodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pincode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      pincodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pincode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      pincodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pincode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      pincodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pincode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      pincodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pincode',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      pincodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pincode',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'signedConsent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'signedConsent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'signedConsent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'signedConsent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'signedConsent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'signedConsent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'signedConsent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'signedConsent',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'signedConsent',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'signedConsent',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentNoReasonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'signedConsentNoReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentNoReasonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'signedConsentNoReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentNoReasonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'signedConsentNoReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentNoReasonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'signedConsentNoReason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentNoReasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'signedConsentNoReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentNoReasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'signedConsentNoReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentNoReasonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'signedConsentNoReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentNoReasonMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'signedConsentNoReason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentNoReasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'signedConsentNoReason',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      signedConsentNoReasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'signedConsentNoReason',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      stateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'state',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      stateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'state',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      stateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      stateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      stateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      stateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'state',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      stateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      stateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      stateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      stateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'state',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      stateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      stateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'state',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      studyCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'studyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      studyCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'studyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      studyCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'studyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      studyCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'studyCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      studyCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'studyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      studyCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'studyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      studyCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'studyCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      studyCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'studyCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      studyCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'studyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      studyCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'studyCode',
        value: '',
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      visitDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'visitDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      visitDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'visitDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      visitDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'visitDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      visitDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'visitDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PatientRegistrationQueryObject on QueryBuilder<PatientRegistration,
    PatientRegistration, QFilterCondition> {
  QueryBuilder<PatientRegistration, PatientRegistration, QAfterFilterCondition>
      consentElement(FilterQuery<AttachmentDb> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'consent');
    });
  }
}

extension PatientRegistrationQueryLinks on QueryBuilder<PatientRegistration,
    PatientRegistration, QFilterCondition> {}

extension PatientRegistrationQuerySortBy
    on QueryBuilder<PatientRegistration, PatientRegistration, QSortBy> {
  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByAadharId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aadharId', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByAadharIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aadharId', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByAlternatePhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alternatePhoneNumber', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByAlternatePhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alternatePhoneNumber', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByConsentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consentDate', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByConsentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consentDate', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByCreatedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdBy', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByCreatedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdBy', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByDistrict() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'district', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByDistrictDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'district', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByInstitutionCodeID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institutionCodeID', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByInstitutionCodeIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institutionCodeID', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByLastName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByLastNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByMedicalRecordNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicalRecordNumber', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByMedicalRecordNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicalRecordNumber', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByOccupation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occupation', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByOccupationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occupation', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByPatientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByPatientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByPermanentAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'permanentAddress', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByPermanentAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'permanentAddress', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByPincode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pincode', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByPincodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pincode', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortBySignedConsent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signedConsent', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortBySignedConsentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signedConsent', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortBySignedConsentNoReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signedConsentNoReason', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortBySignedConsentNoReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signedConsentNoReason', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByStudyCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studyCode', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByStudyCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studyCode', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByVisitDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visitDate', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      sortByVisitDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visitDate', Sort.desc);
    });
  }
}

extension PatientRegistrationQuerySortThenBy
    on QueryBuilder<PatientRegistration, PatientRegistration, QSortThenBy> {
  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByAadharId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aadharId', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByAadharIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aadharId', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByAlternatePhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alternatePhoneNumber', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByAlternatePhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'alternatePhoneNumber', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByConsentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consentDate', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByConsentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consentDate', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByCreatedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdBy', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByCreatedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdBy', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByDistrict() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'district', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByDistrictDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'district', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByFirstName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByFirstNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstName', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByInstitutionCodeID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institutionCodeID', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByInstitutionCodeIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institutionCodeID', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByLastName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByLastNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastName', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByMedicalRecordNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicalRecordNumber', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByMedicalRecordNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicalRecordNumber', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByOccupation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occupation', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByOccupationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occupation', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByPatientId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByPatientIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patientId', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByPermanentAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'permanentAddress', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByPermanentAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'permanentAddress', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByPhoneNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByPhoneNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phoneNumber', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByPincode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pincode', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByPincodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pincode', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenBySignedConsent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signedConsent', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenBySignedConsentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signedConsent', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenBySignedConsentNoReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signedConsentNoReason', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenBySignedConsentNoReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'signedConsentNoReason', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByStudyCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studyCode', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByStudyCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studyCode', Sort.desc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByVisitDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visitDate', Sort.asc);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QAfterSortBy>
      thenByVisitDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'visitDate', Sort.desc);
    });
  }
}

extension PatientRegistrationQueryWhereDistinct
    on QueryBuilder<PatientRegistration, PatientRegistration, QDistinct> {
  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByAadharId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aadharId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByAge({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'age', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByAlternatePhoneNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'alternatePhoneNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByConsentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consentDate');
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByCreatedBy({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdBy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByDistrict({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'district', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByFirstName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByGender({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gender', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByInstitutionCodeID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'institutionCodeID',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByLastName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByMedicalRecordNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'medicalRecordNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByOccupation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'occupation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByPatientId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'patientId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByPermanentAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'permanentAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByPhoneNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phoneNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByPincode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pincode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctBySignedConsent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'signedConsent',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctBySignedConsentNoReason({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'signedConsentNoReason',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByState({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'state', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByStudyCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'studyCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PatientRegistration, PatientRegistration, QDistinct>
      distinctByVisitDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'visitDate');
    });
  }
}

extension PatientRegistrationQueryProperty
    on QueryBuilder<PatientRegistration, PatientRegistration, QQueryProperty> {
  QueryBuilder<PatientRegistration, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PatientRegistration, String?, QQueryOperations>
      aadharIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aadharId');
    });
  }

  QueryBuilder<PatientRegistration, String?, QQueryOperations>
      addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<PatientRegistration, String, QQueryOperations> ageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'age');
    });
  }

  QueryBuilder<PatientRegistration, String?, QQueryOperations>
      alternatePhoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'alternatePhoneNumber');
    });
  }

  QueryBuilder<PatientRegistration, List<AttachmentDb>?, QQueryOperations>
      consentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consent');
    });
  }

  QueryBuilder<PatientRegistration, DateTime, QQueryOperations>
      consentDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consentDate');
    });
  }

  QueryBuilder<PatientRegistration, String, QQueryOperations>
      createdByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdBy');
    });
  }

  QueryBuilder<PatientRegistration, String?, QQueryOperations>
      districtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'district');
    });
  }

  QueryBuilder<PatientRegistration, String, QQueryOperations>
      firstNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstName');
    });
  }

  QueryBuilder<PatientRegistration, String?, QQueryOperations>
      genderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gender');
    });
  }

  QueryBuilder<PatientRegistration, String, QQueryOperations>
      institutionCodeIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'institutionCodeID');
    });
  }

  QueryBuilder<PatientRegistration, String, QQueryOperations>
      lastNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastName');
    });
  }

  QueryBuilder<PatientRegistration, String?, QQueryOperations>
      medicalRecordNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicalRecordNumber');
    });
  }

  QueryBuilder<PatientRegistration, String, QQueryOperations>
      occupationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'occupation');
    });
  }

  QueryBuilder<PatientRegistration, String, QQueryOperations>
      patientIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'patientId');
    });
  }

  QueryBuilder<PatientRegistration, String?, QQueryOperations>
      permanentAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'permanentAddress');
    });
  }

  QueryBuilder<PatientRegistration, String, QQueryOperations>
      phoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phoneNumber');
    });
  }

  QueryBuilder<PatientRegistration, String?, QQueryOperations>
      pincodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pincode');
    });
  }

  QueryBuilder<PatientRegistration, String, QQueryOperations>
      signedConsentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'signedConsent');
    });
  }

  QueryBuilder<PatientRegistration, String, QQueryOperations>
      signedConsentNoReasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'signedConsentNoReason');
    });
  }

  QueryBuilder<PatientRegistration, String?, QQueryOperations> stateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'state');
    });
  }

  QueryBuilder<PatientRegistration, String, QQueryOperations>
      studyCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'studyCode');
    });
  }

  QueryBuilder<PatientRegistration, DateTime, QQueryOperations>
      visitDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'visitDate');
    });
  }
}
