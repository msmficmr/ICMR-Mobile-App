import 'dart:convert';

List<EncounterDetailModel> getEncounterModelFromJson(String str) =>
    List<EncounterDetailModel>.from(
        json.decode(str).map((val) => EncounterDetailModel.fromJson(val)));

String getEncounterModelToJson(List<EncounterDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((val) => val.toJson())));

class EncounterDetailModel {
  EncounterDetailModel({
    this.id,
    this.name,
    this.encounter,
    this.sections,
  });

  String? id;
  String? name;
  Encounter? encounter;
  List<Section>? sections;

  factory EncounterDetailModel.fromJson(Map<String, dynamic> json) =>
      EncounterDetailModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        encounter: json["encounter"] == null
            ? null
            : Encounter.fromJson(json["encounter"]),
        sections: json["sections"] == null
            ? null
            : List<Section>.from(
            json["sections"].map((val) => Section.fromJson(val))),
      );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "encounter": encounter == null ? null : encounter!.toJson(),
    "sections": sections == null
        ? null
        : List<dynamic>.from(sections!.map((val) => val.toJson())),
  };
}

class Encounter {
  Encounter({
    this.createdBy,
    this.createdTime,
    this.lastModifiedBy,
    this.lastModifiedTime,
    this.encounterId,
    this.name,
    this.type,
    this.description,
    this.termsAndCondition,
    this.status,
    this.encounterStates,
    this.healthServiceId,
    this.locationPricing,
    this.image,
  });

  String? createdBy;
  DateTime? createdTime;
  String? lastModifiedBy;
  DateTime? lastModifiedTime;
  String? encounterId;
  String? name;
  String? type;
  String? description;
  String? termsAndCondition;
  String? status;
  List<dynamic>? encounterStates;
  String? healthServiceId;
  LocationPricing? locationPricing;
  String? image;

  factory Encounter.fromJson(Map<String, dynamic> json) => Encounter(
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdTime: json["createdTime"] == null
        ? null
        : DateTime.parse(json["createdTime"]),
    lastModifiedBy:
    json["lastModifiedBy"] == null ? null : json["lastModifiedBy"],
    lastModifiedTime: json["lastModifiedTime"] == null
        ? null
        : DateTime.parse(json["lastModifiedTime"]),
    encounterId: json["encounterId"] == null ? null : json["encounterId"],
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    description: json["description"] == null ? null : json["description"],
    termsAndCondition: json["termsAndCondition"] == null
        ? null
        : json["termsAndCondition"],
    status: json["status"] == null ? null : json["status"],
    encounterStates: json["encounterStates"] == null
        ? null
        : List<dynamic>.from(json["encounterStates"].map((val) => val)),
    healthServiceId:
    json["healthServiceId"] == null ? null : json["healthServiceId"],
    locationPricing: json["locationPricing"] == null
        ? null
        : LocationPricing.fromJson(json["locationPricing"]),
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy == null ? null : createdBy,
    "createdTime":
    createdTime == null ? null : createdTime?.toIso8601String(),
    "lastModifiedBy": lastModifiedBy == null ? null : lastModifiedBy,
    "lastModifiedTime": lastModifiedTime == null
        ? null
        : lastModifiedTime?.toIso8601String(),
    "encounterId": encounterId == null ? null : encounterId,
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "description": description == null ? null : description,
    "termsAndCondition":
    termsAndCondition == null ? null : termsAndCondition,
    "status": status == null ? null : status,
    "encounterStates": encounterStates == null
        ? null
        : List<dynamic>.from(encounterStates!.map((val) => val)),
    "healthServiceId": healthServiceId == null ? null : healthServiceId,
    "locationPricing":
    locationPricing == null ? null : locationPricing!.toJson(),
    "image": image == null ? null : image,
  };
}

class LocationPricing {
  LocationPricing({
    this.locationId,
    this.pricings,
  });

  String? locationId;
  List<Pricing>? pricings;

  factory LocationPricing.fromJson(Map<String, dynamic> json) =>
      LocationPricing(
        locationId: json["locationId"] == null ? null : json["locationId"],
        pricings: json["pricings"] == null
            ? null
            : List<Pricing>.from(
            json["pricings"].map((val) => Pricing.fromJson(val))),
      );

  Map<String, dynamic> toJson() => {
    "locationId": locationId == null ? null : locationId,
    "pricings": pricings == null
        ? null
        : List<dynamic>.from(pricings!.map((val) => val.toJson())),
  };
}

class Pricing {
  Pricing({
    this.createdBy,
    this.createdTime,
    this.lastModifiedBy,
    this.lastModifiedTime,
    this.pricingId,
    this.currencyType,
    this.amount,
    this.status,
  });

  String? createdBy;
  dynamic createdTime;
  String? lastModifiedBy;
  dynamic lastModifiedTime;
  String? pricingId;
  dynamic currencyType;
  String? amount;
  String? status;

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdTime: json["createdTime"],
    lastModifiedBy:
    json["lastModifiedBy"] == null ? null : json["lastModifiedBy"],
    lastModifiedTime: json["lastModifiedTime"],
    pricingId: json["pricingId"] == null ? null : json["pricingId"],
    currencyType: json["currencyType"],
    amount: json["amount"] == null ? null : json["amount"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy == null ? null : createdBy,
    "createdTime": createdTime == null ? null : createdTime,
    "lastModifiedBy": lastModifiedBy == null ? null : lastModifiedBy,
    "lastModifiedTime": lastModifiedTime == null ? null : lastModifiedTime,
    "pricingId": pricingId == null ? null : pricingId,
    "currencyType": currencyType == null ? null : currencyType,
    "amount": amount == null ? null : amount,
    "status": status == null ? null : status,
  };
}

class Section {
  Section({
    this.encounterCategoryMapId,
    this.encounterServiceName,
    this.noteName,
    this.seqNo,
    this.active,
    this.ehrCategory,
  });

  String? encounterCategoryMapId;
  String? encounterServiceName;
  String? noteName;
  int? seqNo;
  bool? active;
  EhrCategory? ehrCategory;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    encounterCategoryMapId: json["encounterCategoryMapId"] == null
        ? null
        : json["encounterCategoryMapId"],
    encounterServiceName: json["encounterServiceName"] == null
        ? null
        : json["encounterServiceName"],
    noteName: json["noteName"] == null ? null : json["noteName"],
    seqNo: json["seqNo"] == null ? null : json["seqNo"],
    active: json["active"] == null ? null : json["active"],
    ehrCategory: json["ehrCategory"] == null
        ? null
        : EhrCategory.fromJson(json["ehrCategory"]),
  );

  Map<String, dynamic> toJson() => {
    "encounterCategoryMapId":
    encounterCategoryMapId == null ? null : encounterCategoryMapId,
    "encounterServiceName":
    encounterServiceName == null ? null : encounterServiceName,
    "noteName": noteName == null ? null : noteName,
    "seqNo": seqNo == null ? null : seqNo,
    "active": active == null ? null : active,
    "ehrCategory": ehrCategory == null ? null : ehrCategory!.toJson(),
  };
}

class EhrCategory {
  EhrCategory({
    this.createdBy,
    this.createdTime,
    this.lastModifiedBy,
    this.lastModifiedTime,
    this.ehrCategoryId,
    this.name,
    this.dataTypes,
    this.filter,
    this.description,
  });

  String? createdBy;
  DateTime? createdTime;
  String? lastModifiedBy;
  DateTime? lastModifiedTime;
  String? ehrCategoryId;
  String? name;
  List<DataType>? dataTypes;
  String? filter;
  String? description;

  factory EhrCategory.fromJson(Map<String, dynamic> json) => EhrCategory(
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdTime: json["createdTime"] == null
        ? null
        : DateTime.parse(json["createdTime"]),
    lastModifiedBy:
    json["lastModifiedBy"] == null ? null : json["lastModifiedBy"],
    lastModifiedTime: json["lastModifiedTime"] == null
        ? null
        : DateTime.parse(json["lastModifiedTime"]),
    ehrCategoryId:
    json["ehrCategoryId"] == null ? null : json["ehrCategoryId"],
    name: json["name"] == null ? null : json["name"],
    dataTypes: json["dataTypes"] == null
        ? null
        : List<DataType>.from(
        json["dataTypes"].map((val) => DataType.fromJson(val))),
    filter: json["filter"] == null ? null : json["filter"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy == null ? null : createdBy,
    "createdTime":
    createdTime == null ? null : createdTime?.toIso8601String(),
    "lastModifiedBy": lastModifiedBy == null ? null : lastModifiedBy,
    "lastModifiedTime": lastModifiedTime == null
        ? null
        : lastModifiedTime?.toIso8601String(),
    "ehrCategoryId": ehrCategoryId == null ? null : ehrCategoryId,
    "name": name == null ? null : name,
    "dataTypes": dataTypes == null
        ? null
        : List<dynamic>.from(dataTypes!.map((val) => val.toJson())),
    "filter": filter == null ? null : filter,
    "description": description == null ? null : description,
  };
}

class DataType {
  DataType({
    this.id,
  });

  String? id;

  factory DataType.fromJson(Map<String, dynamic> json) => DataType(
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
  };
}
