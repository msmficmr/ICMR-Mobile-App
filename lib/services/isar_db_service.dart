import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDbService {
  //IsarDbService _isarDb;
  late Future<Isar> isar;

  IsarDbService._() {
    openIsarDb();
  }
  static Future<Isar> openIsarDb() async {
    final dir = await getApplicationSupportDirectory();
    return Isar.open([TodoSchema], directory: dir.path);
  }

  static IsarDbService isarDbService = IsarDbService._();

  Future<void> writeData() async {
    final todo = Todo();
    // ignore: avoid_single_cascade_in_expression_statements
    todo.title = "Sanjay";
    todo.date = DateTime.now();
    todo.isDone = true;
    todo.isImportant = false;
    Isar? db = await isar;
    try {
      await db.writeTxn(() async {
        await db.todos.put(todo);
      });
    } catch (e) {
      print(e);
    }
  }
}
