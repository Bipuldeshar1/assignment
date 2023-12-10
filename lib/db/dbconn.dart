import 'dart:convert';

import 'package:internship_test/models/comment_model.dart';
import 'package:internship_test/models/post_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  Future<Database> opendbconn() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'api_db.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE post(id INTEGER PRIMARY KEY,userId INTEGER, title TEXT, body TEXT)',
        );
        await db.execute(
          'CREATE TABLE comment(postId INTEGER, id INTEGER , name TEXT, email TEXT, body TEXT)',
        );
      },
    );
  }

  Future<void> insertPost(List<PostModel> postModel) async {
    final db = await opendbconn();

    if (db != null) {
      try {
        for (var postModel in postModel) {
          await db.insert(
            'post',
            postModel.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          print('Data inserted successfully: $postModel');
        }
        print(postModel);
      } catch (e) {
        print('Error inserting data: $e');
      }
    } else {
      print('no');
    }
  }

  Future<List<PostModel>> getPost() async {
    final db = await opendbconn();
    final List<Map<String, dynamic>> maps = await db.query('post');
    return List.generate(maps.length, (index) {
      return PostModel(
        id: maps[index]['id'],
        userid: maps[index]['userId'],
        title: maps[index]['title'],
        body: maps[index]['body'],
      );
    });
  }

  Future<void> insertcmt(List<CommentModel> cmtModel) async {
    final db = await opendbconn();

    if (db != null) {
      try {
        for (var cmt in cmtModel) {
          await db.insert(
            'comment',
            cmt.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          print('Data inserted successfully: $cmt');
        }
        print(cmtModel);
      } catch (e) {
        print('Error inserting data: $e');
      }
    } else {
      print('no');
    }
  }

  Future<List<CommentModel>> getCmt() async {
    final db = await opendbconn();
    final List<Map<String, dynamic>> maps = await db.query('comment');
    return List.generate(maps.length, (index) {
      return CommentModel(
          postid: maps[index]['postId'],
          id: maps[index]['id'],
          name: maps[index]['name'],
          email: maps[index]['email'],
          body: maps[index]['body']);
    });
  }
}
