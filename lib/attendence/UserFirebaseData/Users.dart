import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String profileFirstName;
  final String profileLastName;
  final String profileMiddleName;
  final String url;
  final String email;
  final String semester;
  final String branch;


  User({
    this.id,
    this.profileFirstName,
    this.profileMiddleName,
    this.profileLastName,
    this.url,
    this.email,
    this.semester,
    this.branch


  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      email: doc['email'],
      url: doc['url'],
      profileFirstName: doc['profileFirstName'],
      profileMiddleName: doc['profileMiddleName'],
      profileLastName: doc['profileLastName'],
      semester: doc['semester'],
      branch: doc['branch'],


    );
  }
}