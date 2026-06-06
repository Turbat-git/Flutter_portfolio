import 'package:hive_flutter/hive_flutter.dart';
import 'package:tt_flutter_portfolio/models/todo.dart';
import './datasource.dart';

class HiveDatasource implements IDataSource {
  Future initialise() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    await Hive.openBox<Todo>('todos');
  }

  static Future<IDataSource> createAsync() async {
    HiveDatasource datasource = HiveDatasource();
    await datasource.initialise();
    return datasource;
  }

  @override
  Future<bool> add(Todo todo) async {
    Box<Todo> box = Hive.box('todos');
    int id = await box.add(todo);
    await edit(todo.copyWith(id: id.toString()));
    return true;
  }

  @override
  Future<List<Todo>> browse() async {
    Box<Todo> box = Hive.box('todos');
    return box.values.toList();
  }

  @override
  Future<bool> delete(Todo todo) async {
    Box<Todo> box = Hive.box('todos');
    await box.delete(todo.id);
    return true;
  }

  @override
  Future<bool> edit(Todo todo) {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Future<Todo?> read(Todo todo) async {
    final box = Hive.box<Todo>('todos');
    final result = box.get(int.parse(todo.id));
    return result;
  }
}
