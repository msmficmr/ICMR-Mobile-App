import 'package:isar/isar.dart';

part 'attachment_db_schema.g.dart';

@embedded
class AttachmentDb {
  late String? fileName;

  late List<byte>? image;

  // Add a toJson method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'image': image,
    };
  }
}
