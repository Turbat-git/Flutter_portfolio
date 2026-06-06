import '../models/todo.dart';
import 'datasource.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../firebase_options.dart';

class ApiDatasource implements IDataSource {
  late FirebaseDatabase _database;

  Future initialise() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _database = FirebaseDatabase.instance;
  }

  static Future<IDataSource> createAsync() async {
    ApiDatasource datasource = ApiDatasource();
    await datasource.initialise();
    return datasource;
  }

  // --- BREAD OPERATIONS ---

  @override
  Future<bool> add(Todo todo) async {
    DatabaseReference newTodoRef = _database.ref('todos').push();

    // Uses copyWith to safely inject the newly generated Firebase key
    await newTodoRef.set(todo.copyWith(id: newTodoRef.key).toMap());
    return true;
  }

  @override
  Future<List<Todo>> browse() async {
    final DataSnapshot snapshot = await _database.ref('todos').get();

    if (!snapshot.exists) {
      // Returning an empty list is generally safer than throwing an exception
      // if the database is just empty.
      return [];
    }

    // Fixed: Assigned the mapped data to the 'todos' list variable
    // instead of letting the mapped result float unassigned.
    List<Todo> todos = (snapshot.value as Map).values
        .map((e) => Map<String, dynamic>.from(e))
        .map((e) => Todo.fromMap(e))
        .toList();

    return todos;
  }

  @override
  Future<Todo?> read(Todo todo) async {
    // Standardized to take an ID string and return the actual Todo object
    final DataSnapshot snapshot = await _database.ref('todos/${todo.id}').get();

    if (!snapshot.exists) {
      return null;
    }

    // Safely cast the snapshot value and pass it to your factory
    final map = Map<String, dynamic>.from(snapshot.value as Map);
    return Todo.fromMap(map);
  }

  @override
  Future<bool> edit(Todo todo) async {
    // Uses .update() so it only overwrites the fields provided in the map
    await _database.ref('todos/${todo.id}').update(todo.toMap());
    return true;
  }

  @override
  Future<bool> delete(Todo todo) async {
    // Targets the specific ID and removes the node completely
    await _database.ref('todos/${todo.id}').remove();
    return true;
  }
}
