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

  @override
  Future<bool> add(Todo todo) async {
    DatabaseReference newTodoRef = _database.ref('todos').push();
    await newTodoRef.set(todo.copyWith(id: newTodoRef.key).toMap());
    return true;
  }

  @override
  Future<List<Todo>> browse() async {
    // DatabaseReference ref = _database.ref();
    // final DataSnapshot snapshot = await ref.child('todos').get();

    final DataSnapshot snapshot = await _database.ref('todos').get();

    if (!snapshot.exists) {
      throw Exception(
        'Invalid Request - Cannot find Snapshot ${snapshot.ref.path}',
      );
    }

    List<Todo> todos = <Todo>[];
    (snapshot.value as Map).values
        .map((e) => Map<String, dynamic>.from(e))
        .map((e) => Todo.fromMap(e))
        .toList();

    //TODO: Fix this to return actual data from the snapshot.
    return [];
  }

  @override
  Future<bool> delete(Todo todo) async {
    await _database.ref('todos/${todo.id}').remove();

    return true;
  }

  @override
  Future<bool> edit(Todo todo) {
    // TODO: implement edit
    throw UnimplementedError();
  }

  @override
  Future<bool> read(Todo todo) async {
    // DataSnapshot snapshot = await _database.ref('todos/${todo.id}').get();

    // if (!snapshot.exists) {
    //   throw Exception(
    //     'Invalid Request - Cannot find Snapshot ${snapshot.ref.path}',
    //   );
    // }

    // return Todo.fromMap(snapshot.value as Map<String, dynamic>);
    throw UnimplementedError();
  }
}
