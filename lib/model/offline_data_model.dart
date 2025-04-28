
import 'dart:convert';

OfflineDataModel offlineDataModelFromJson(String str) => OfflineDataModel.fromJson(json.decode(str));

String offlineDataModelToJson(OfflineDataModel data) => json.encode(data.toJson());

class OfflineDataModel {
    int numberOfElements;

    OfflineDataModel({
        required this.numberOfElements,
    });

    factory OfflineDataModel.fromJson(Map<String, dynamic> json) => OfflineDataModel(
        numberOfElements: json["numberOfElements"],
    );

    Map<String, dynamic> toJson() => {
        "numberOfElements": numberOfElements,
    };
}
