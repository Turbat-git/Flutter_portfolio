import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:tt_flutter_portfolio/services/api_datasource.dart';
import 'package:tt_flutter_portfolio/services/hive_datasource.dart';
// import 'package:tt_flutter_portfolio/services/sql_datasource.dart';

import './services/datasource.dart';
import './models/todo_list.dart';
import './views/todo_widget.dart';
import './models/todo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.putAsync<IDataSource>(() => ApiDatasource.createAsync()).whenComplete(
    () => runApp(
      ChangeNotifierProvider(
        create: (context) => TodoList(),
        child: const ToDoApp(),
      ),
    ),
  );
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: TodoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Fancy Todo App'),
        backgroundColor: Theme.of(context).primaryColorLight,
        actions: [
          Builder(
            builder: (context) {
              // CHANGED: listen is set to true so the counter updates dynamically
              final todoList = Provider.of<TodoList>(context, listen: true);

              // Use the .where() filter as requested
              final incompleteCount = todoList.todos
                  .where((todo) => !todo.complete)
                  .length;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    'Incomplete: $incompleteCount',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Consumer<TodoList>(
          builder: (BuildContext context, TodoList stateObject, Widget? child) {
            return RefreshIndicator(
              onRefresh: stateObject.refresh,
              child: ListView.builder(
                itemCount: stateObject.todos.length,
                itemBuilder: (context, index) {
                  return TodoWidget(todo: stateObject.todos[index]);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodo,
        child: Icon(Icons.add),
      ),
    );
  }

  void _openAddTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5, 9, 5, 0),
                child: Text('Name'),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 9, 5, 0),
                child: TextFormField(controller: _controllerName),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 9, 5, 0),
                child: Text('Description'),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 9, 5, 0),
                child: TextFormField(controller: _controllerDescription),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Provider.of<TodoList>(context, listen: false).addTodo(
                      Todo(
                        id: 'This is removed and will be created automatically by the DB',
                        name: _controllerName.text,
                        description: _controllerDescription.text,
                      ),
                    );
                    Provider.of<TodoList>(context, listen: false).refresh();
                  });
                  Navigator.pop(context);
                  _controllerDescription.clear();
                  _controllerName.clear();
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }
}
