import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  // final String postId;
  final String link;
  final String mod;
  // final DateTime timestamp;

  Video({this.link, this.mod});

  factory Video.fromDocument(DocumentSnapshot documentSnapshot) {
    return Video(
      // postId: documentSnapshot["postId"],
      link: documentSnapshot["link"],
      mod: documentSnapshot["mod"],

      // timestamp: documentSnapshot["timestamp"],
    );
  }

  @override
  _VideoState createState() => _VideoState(
        // postId: this.postId,
        link: this.link,
        mod: this.mod,
      );
}

class _VideoState extends State<Video> {
  // final String postId;
  final String link;
  final String mod;
  // final DateTime timestamp;

  // int likeCount;
  // bool isLiked;
  // bool showHeart = false;

  _VideoState({this.link, this.mod});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class VideoSem extends StatefulWidget {
  // final String postId;
  final String val;
  final String max;

  // final DateTime timestamp;

  VideoSem({this.val, this.max});

  factory VideoSem.fromDocument(DocumentSnapshot documentSnapshot) {
    return VideoSem(
      // postId: documentSnapshot["postId"],
      val: documentSnapshot["val"],
      max: documentSnapshot["max"],

      // timestamp: documentSnapshot["timestamp"],
    );
  }

  @override
  _VideoSemState createState() => _VideoSemState(
        // postId: this.postId,
        val: this.val,
      );
}

class _VideoSemState extends State<VideoSem> {
  // final String postId;
  final String val;
  // final String mod;
  // final DateTime timestamp;

  // int likeCount;
  // bool isLiked;
  // bool showHeart = false;

  _VideoSemState({this.val});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}