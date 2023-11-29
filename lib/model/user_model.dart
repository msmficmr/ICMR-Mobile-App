class UserModel {
    String? id;
    String? userId;
    int? version;
    String? userName;
    String? salutation;
    String? firstName;
    dynamic middleName;
    String? lastName;
    String? email;
    String? mobileNumber;
    String? gender;
    List<String>? roles;
    DateTime? dob;
    String? age;
    dynamic organizations;
    List<Location>? locations;
    bool? isDeleted;
    String? createdBy;
    DateTime? createdOn;
    String? lastModifiedBy;
    DateTime? lastModifiedOn;
    dynamic profileName;
    String? fullNameSearchable;
    String? fullName;
    int? v;

    UserModel({
        this.id,
        this.userId,
        this.version,
        this.userName,
        this.salutation,
        this.firstName,
        this.middleName,
        this.lastName,
        this.email,
        this.mobileNumber,
        this.gender,
        this.roles,
        this.dob,
        this.age,
        this.organizations,
        this.locations,
        this.isDeleted,
        this.createdBy,
        this.createdOn,
        this.lastModifiedBy,
        this.lastModifiedOn,
        this.profileName,
        this.fullNameSearchable,
        this.fullName,
        this.v,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        userId: json["userId"],
        version: json["version"],
        userName: json["userName"],
        salutation: json["salutation"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        gender: json["gender"],
        roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        age: json["age"],
        organizations: json["organizations"],
        locations: json["locations"] == null ? [] : List<Location>.from(json["locations"]!.map((x) => Location.fromJson(x))),
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedOn: json["lastModifiedOn"] == null ? null : DateTime.parse(json["lastModifiedOn"]),
        profileName: json["profileName"],
        fullNameSearchable: json["fullNameSearchable"],
        fullName: json["fullName"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "version": version,
        "userName": userName,
        "salutation": salutation,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "email": email,
        "mobileNumber": mobileNumber,
        "gender": gender,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "dob": dob?.toIso8601String(),
        "age": age,
        "organizations": organizations,
        "locations": locations == null ? [] : List<dynamic>.from(locations!.map((x) => x.toJson())),
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "createdOn": createdOn?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedOn": lastModifiedOn?.toIso8601String(),
        "profileName": profileName,
        "fullNameSearchable": fullNameSearchable,
        "fullName": fullName,
        "__v": v,
    };
}

class Location {
    String? locationId;
    String? locationName;

    Location({
        this.locationId,
        this.locationName,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        locationId: json["locationId"],
        locationName: json["locationName"],
    );

    Map<String, dynamic> toJson() => {
        "locationId": locationId,
        "locationName": locationName,
    };
}