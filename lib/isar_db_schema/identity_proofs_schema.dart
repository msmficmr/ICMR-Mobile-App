import 'package:isar/isar.dart';

part 'identity_proofs_schema.g.dart';

@embedded
class IdentityProofDb {
  late String? type;
  late String? value;

  // Add a toJson method to convert the object to JSON
  toJson() {
    return {
      'fileName': type,
      'dataBytes': value,
    };
  }
}