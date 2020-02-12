// import 'dart:html';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpExample extends StatefulWidget {
  @override
  HttpState createState() => HttpState();
}

class HttpState extends State<HttpExample> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('HTTP Example'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.list), onPressed: showResponse)
      ],
    ));
  }

  void showResponse() {
    
    print(fetchNote());
  }

  Future<dynamic> fetchNote() async {

    final response = await http.get('http://localhost:8080/api/users/notes', headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer qBthqR7Tg7zZGLl4/90waw=="

    });

    print(response.body);
    // return Note.fromJson(json.decode(response.body)); 
  }
}

class Note {
  final String headline;
  final String story; 

  Note(this.headline, this.story);

  Note.fromJson(Map<String, dynamic> json)
      : headline = json['headline'],
        story = json['story'];

  Map<String, dynamic> toJson() =>
    {
      'headline': headline,
      'story': story,
    };
}