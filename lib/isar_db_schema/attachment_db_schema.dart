import 'package:isar/isar.dart';

part 'attachment_db_schema.g.dart';

@embedded
class AttachmentDb {
  late String? fileName;

  late List<byte>? image;
}
