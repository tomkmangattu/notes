import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  // final String postId;
  final String link;
  final String mod;
  final String approval;
  final String size;
  // final DateTime timestamp;

  Note({this.link, this.mod, this.approval, this.size});

  factory Note.fromDocument(DocumentSnapshot documentSnapshot) {
    return Note(
      // postId: documentSnapshot["postId"],
      link: documentSnapshot["link"],
      mod: documentSnapshot["mod"],
      approval: documentSnapshot['approval'],
      size: documentSnapshot['size'],

      // timestamp: documentSnapshot["timestamp"],
    );
  }

  @override
  _NoteState createState() => _NoteState(
      // postId: this.postId,
      link: this.link,
      mod: this.mod,
      approval: this.approval,
      size: this.size);
}

class _NoteState extends State<Note> {
  // final String postId;
  final String link;
  final String mod;
  final String approval;
  final String size;
  // final DateTime timestamp;

  // int likeCount;
  // bool isLiked;
  // bool showHeart = false;

  _NoteState({this.link, this.mod, this.approval, this.size});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NoteSem extends StatefulWidget {
  // final String postId;
  final String val;
  final String max;

  // final DateTime timestamp;

  NoteSem({this.val, this.max});

  factory NoteSem.fromDocument(DocumentSnapshot documentSnapshot) {
    return NoteSem(
      // postId: documentSnapshot["postId"],
      val: documentSnapshot["val"],
      max: documentSnapshot["max"],

      // timestamp: documentSnapshot["timestamp"],
    );
  }

  @override
  _NoteSemState createState() => _NoteSemState(
        // postId: this.postId,
        val: this.val,
      );
}

class _NoteSemState extends State<NoteSem> {
  // final String postId;
  final String val;
  // final String mod;
  // final DateTime timestamp;

  // int likeCount;
  // bool isLiked;
  // bool showHeart = false;

  _NoteSemState({this.val});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NoteForm extends StatefulWidget {
  // final String postId;
  final String link;

  // final DateTime timestamp;

  NoteForm({this.link});

  factory NoteForm.fromDocument(DocumentSnapshot documentSnapshot) {
    return NoteForm(
      // postId: documentSnapshot["postId"],
      link: documentSnapshot["link"],

      // timestamp: documentSnapshot["timestamp"],
    );
  }

  @override
  _NoteFormState createState() => _NoteFormState(
        // postId: this.postId,
        link: this.link,
      );
}

class _NoteFormState extends State<NoteForm> {
  // final String postId;
  final String link;
  // final String mod;
  // final DateTime timestamp;

  // int likeCount;
  // bool isLiked;
  // bool showHeart = false;

  _NoteFormState({this.link});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}