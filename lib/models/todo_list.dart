//this is my state object
import 'dart:collection';

import 'package:flutter/widgets.dart';
import './todo.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = <Todo>[
    Todo(
      name: 'Get Food',
      description:
          'Stand in front of fridge for 10 minutes and decide I dont want anything in there',
    ),
    Todo(name: 'Solve World Hunger', description: 'Dont use fridge'),
    Todo(
      name: 'Catch the Fridge',
      description: 'We are going to need a bigger boat',
      complete: true,
    ),
  ];

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get todoCount => _todos.length;

  void addTodo(Todo value) {
    _todos.add(value);
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
    int index = _todos.indexOf(value);
    _todos[index] = value;

    notifyListeners();
  }
}
