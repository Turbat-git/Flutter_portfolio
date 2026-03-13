import '../models/todo.dart';
import './datasource.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatasource implements IDataSource {
  late Database _database;

  Future initialise() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'todo_data.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY, name TEXT, description TEXT, complete INTEGER)',
        );
      },
    );
  }

  static Future<IDataSource> createAsync() async {
    SqlDatasource datasource = SqlDatasource();
    await datasource.initialise();
    return datasource;
  }

  @override
  Future<bool> add(Todo todo) async {
    Map<String, dynamic> editedMap = todo.toMap();
    editedMap.remove('id'); //edited map now has the id removed

    return await _database.insert('todos', editedMap) != 0;
  }

  @override
  Future<List<Todo>> browse() async {
    List<Map<String, dynamic>> maps = await _database.query('todos');
    return List.generate(maps.length, (index) {
      return Todo.fromMap(maps[index]);
    });
  }

  @override
  Future<bool> delete(Todo todo) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> edit(Todo todo) {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Future<bool> read(Todo todo) {
    // TODO: implement read
    throw UnimplementedError();
  }
}
