
import 'package:path_provider/path_provider.dart';
import'package:sqflite/sqflite.dart';
import 'package:todo_app/model/todoModel.dart';

class DbHelper {

  static final DbHelper instance = DbHelper._internal();

  final String _tableName = 'todos';

  DbHelper._internal();

  Database? _database;

  Future<Database> get db async {
    _database ??= await _initializeDb();
    return _database!;
  }

  Future<Database> _initializeDb() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/todo_db.db';

    return await openDatabase(
        path,
        version: 1,
        onCreate: (database, version) {
          database.execute('CREATE TABLE $_tableName('
              'id INTEGER PRIMARY KEY,'
              'title TEXT,'
              'description TEXT,'
              'date TEXT,'
              'time TEXT'
              ')');
        }
    );
  }

  Future<int> insert(TodoModel todo) async
  {
    return await (await db).insert(_tableName, {
      'id': todo.id,
      'title': todo.Title,
      'description': todo.Description,
      'date': todo.date,
      'time':todo.time,
    },);
  }

  Future<int> update(TodoModel todo) async {
    return await (await db).update(
      _tableName,
      {
        'title': todo.Title,
        'description': todo.Description,
        'date': todo.date,
        'time': todo.time,
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }




  Future<int> delete(int todoId) async {
    return await (await db).delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [todoId],
    );
  }




Future<List<TodoModel>> getAll() async {
  final response = await (await db).query(_tableName);
  final todos = <TodoModel>[];
  for (var data in response) {
    final todo = TodoModel(
      id: int.parse(data['id'].toString()),
      Title: data['title'].toString(),
      Description: data['description'].toString(),
      date: data['date'].toString(),
      time: data['time'].toString(),
    );
    todos.add(todo);
  }
  return todos;
}



}