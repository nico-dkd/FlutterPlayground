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

  final notes = List<Note>();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('HTTP Example'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.list), onPressed: showResponse)
      ],
    ),
    body: _buildList()
    ,);
  }

  Widget _buildList() {
    showResponse();
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, item) {
        print(item);
        if (notes.length >= 1) {
          return _buildRow(notes[item]);
        } else { 
         return ListTile(
            title: Text('Hallo'),
          );
        }
      },);
  }

  Widget  _buildRow(Note note) {
    return ListTile(
      title: Text(note.headline),
      subtitle: Text(note.story),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: <Widget>[
      //     Text(note.headline, style: TextStyle(color: Colors.red),),
      //     Text(note.story)
      //   ],
      // )
      // // title: Text(note.headline),
    );
  }

  void showResponse() async {
    
    final ya = await fetchNote();
    ya.forEach((note) => notes.add(note));
  }

  Future <List<Note>> fetchNote() async {

    final response = await http.get('http://localhost:8080/api/users/notes', headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer 256+Fp3PRvv1KSGc9qbwPw=="

    });
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Note>((json) => Note.fromJson(json)).toList();
  }
}

class Note {
  final String headline;
  final String story;

  Note({this.headline, this.story});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      headline: json['headline'] as String,
      story: json['story'] as String,
    );
  }
}