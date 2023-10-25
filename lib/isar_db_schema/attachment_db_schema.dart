import 'package:isar/isar.dart';

part 'attachment_db_schema.g.dart';

@embedded
class AttachmentDb {
  late String? fileName;

  late String? dataBytes;

  // Add a toJson method to convert the object to JSON
  toJson() {
    return {
      'fileName': fileName,
      'dataBytes': dataBytes,
    };
  }
}
