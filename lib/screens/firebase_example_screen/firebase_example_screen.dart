import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_starter_app/utils/api/models/person_model.dart';

class FirebaseExampleScreen extends StatefulWidget {
  FirebaseExampleScreen({Key key}) : super(key: key);

  @override
  _FirebaseExampleScreenState createState() => _FirebaseExampleScreenState();
}

class _FirebaseExampleScreenState extends State<FirebaseExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(
          context,
          'firebase_example_screen.title',
        )),
      ),
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    // name of the collection created in firebase project
    stream: Firestore.instance.collection('people').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();
      return ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children: snapshot.data.documents
            .map((data) => _buildListItem(context, data))
            .toList(),
      );
    },
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final person = Person.fromSnapshot(data);
  return Padding(
    key: ValueKey(person.name),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(person.name),
        trailing: Text(person.likes.toString()),
        // use transaction for increment data
        onTap: () => Firestore.instance.runTransaction((transaction) async {
          final freshSnapshot = await transaction.get(person.reference);
          final updatedPerson = Person.fromSnapshot(freshSnapshot);
          var updatedLikes = {'likes': updatedPerson.likes + 1};
          await transaction.update(person.reference, updatedLikes);
        }),
      ),
    ),
  );
}
