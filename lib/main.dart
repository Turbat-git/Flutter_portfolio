import 'package:flutter/material.dart';
import './models/todo.dart';

void main() {
  runApp(const ToDoApp());
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
  final List<Todo> todos = <Todo>[
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

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Fancy Todo App'),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            // This is what each todo will look like.
            return Card(
              color: todos[index].complete ? Colors.green : Colors.orange,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(todos[index].name),
                          Text(todos[index].description),
                        ],
                      ),
                    ),
                    Checkbox(
                      value: todos[index].complete,
                      onChanged: (value) {},
                    ),
                  ],
                ),
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
                    todos.add(
                      Todo(
                        name: _controllerName.text,
                        description: _controllerDescription.text,
                      ),
                    );
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
