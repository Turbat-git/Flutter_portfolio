//this is my state object
import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:tt_flutter_portfolio/services/datasource.dart';
import 'package:get/get.dart';

import './todo.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = <Todo>[];

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get todoCount => _todos.length;
  int get todoCompleteCount =>
      _todos.where((element) => element.complete).toList().length;

  Future<List<Todo>> refresh() async {
    IDataSource dataSource = Get.find();

    _todos.clear();
    _todos.addAll(await dataSource.browse());
    notifyListeners();
    return _todos;
  }

  Future addTodo(Todo value) async {
    IDataSource dataSource = Get.find();
    await dataSource.add(value);
    notifyListeners();
  }

  void removeAllTodo() {
    _todos.clear();
    notifyListeners();
  }

  void removeTodo(Todo value) {
    _todos.remove(value);
    notifyListeners();
  }

  //TODO: Validate the implementation of index of vs the mutability of the todo
  void updateTodo(Todo value) {
    int index = _todos.indexWhere(
      (t) => t.name.toLowerCase() == value.name.toLowerCase(),
    );

    _todos[index] = value;

    notifyListeners();
  }
}
