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
  Future<bool> add(Todo todo) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> browse() {
    // TODO: implement browse
    throw UnimplementedError();
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
