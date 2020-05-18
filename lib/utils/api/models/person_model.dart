import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  final String name;
  final int likes;
  final DocumentReference reference;

  Person.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['likes'] != null),
        name = map['name'],
        likes = map['likes'];

  Person.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => 'Person<$name:$likes>';
}
