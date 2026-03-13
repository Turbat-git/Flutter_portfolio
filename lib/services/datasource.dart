import '../models/todo.dart';

abstract class IDataSource {
  Future<List<Todo>> browse();
  Future<bool> add(Todo todo);
  Future<bool> delete(Todo todo);
  Future<bool> read(Todo todo);
  Future<bool> edit(Todo todo);
}
