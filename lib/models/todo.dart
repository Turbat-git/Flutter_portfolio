class Todo {
  final String id;
  final String name;
  final String description;
  final bool complete;

  Todo({
    required this.id,
    required this.name,
    required this.description,
    this.complete = false,
  });

  @override
  String toString() {
    return '$name - ($description) [${complete ? 'Complete' : 'Not Complete'}]';
  }

  Todo copyWith({
    String? id,
    String? name,
    String? description,
    bool? complete,
  }) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.name,
      complete: complete ?? this.complete,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'complete': complete,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    //Assign from bool as priority if it is bool
    bool? complete = map['complete'] is bool ? map['complete'] : null;

    //otherwise if it is null, check if it is an int and assign based on that value.
    complete ??= map['complete'] == 1;

    return Todo(
      id: map['id']
          .toString(), // If it is an int from the DB, convert to string
      name: map['name'],
      description: map['description'],
      complete: complete,
    );
  }
}
