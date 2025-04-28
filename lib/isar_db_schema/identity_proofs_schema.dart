import 'package:isar/isar.dart';
import 'package:mhealth/utils/exceptions/app_exception.dart';

part 'identity_proofs_schema.g.dart';

@embedded
class IdentityProofDb {
  late String? identityType;
  late String? value;
  IdentityProofDb();

  factory IdentityProofDb.fromJson(Map<String, dynamic> data) {
    if (data.containsKey("identityType") && data.containsKey("value")) {
    } else {
      throw ServerException(message: "Some fields are missing");
    }

    IdentityProofDb identityProofDb = IdentityProofDb();
    identityProofDb.identityType = data['identityType'];
    identityProofDb.value = data['value'];
    return identityProofDb;
  }

  // Add a toJson method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'identityType': identityType,
      'value': value,
    };
  }
}
