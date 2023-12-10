import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internship_test/db/dbconn.dart';
import 'package:internship_test/models/comment_model.dart';
import 'package:internship_test/models/post_model.dart';
import 'package:internship_test/network/base_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:internship_test/utils/sharedpreference.dart';

class NetworkService extends BaseApiServices {
  SharedPreferencesPost sp = SharedPreferencesPost();
  DbConnection dbConnection = DbConnection();
  @override
  Future<List<PostModel>> getGetApiResponse() async {
    String url = 'https://jsonplaceholder.typicode.com/posts';

    var connResult = await Connectivity().checkConnectivity();
    if (connResult == ConnectivityResult.none) {
      print('no internet');
      // return await sp.getPost();
      return await dbConnection.getPost();
    } else {
      try {
        final res = await http.get(Uri.parse(url));
        if (res.statusCode == 200) {
          List<dynamic> data = jsonDecode(res.body);
          var post = data.map((e) => PostModel.fromJson(e)).toList();

          await dbConnection.insertPost(post);
          //await sp.savePost(post);
          return post;
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }
  }

  @override
  Future<List<CommentModel>> getGetApiRes(int id) async {
    String url = 'https://jsonplaceholder.typicode.com/posts/$id/comments';
    var connResult = await Connectivity().checkConnectivity();
    if (connResult == ConnectivityResult.none) {
      print('no internetcmt');
      return await dbConnection.getCmt();
      // return await sp.getcmt();
    } else {
      try {
        final res = await http.get(Uri.parse(url));
        if (res.statusCode == 200) {
          List<dynamic> data = jsonDecode(res.body);
          var cmt = data.map((e) => CommentModel.fromJson(e)).toList();
          await dbConnection.insertcmt(cmt);
          // await sp.savecmt(cmt);
          return cmt;
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }
  }

  @override
  Future<CommentModel> getPostApiResponse(
      int postId, String name, String email, String body) async {
    String url = 'https://jsonplaceholder.typicode.com/posts/$postId/comments';
    Map<String, dynamic> data = {
      'postId': postId,
      'id': 0,
      'name': name,
      'email': email,
      'body': body,
    };
    try {
      final res = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      print(data.toString());
      if (res.statusCode == 201) {
        return CommentModel.fromJson(jsonDecode(res.body));
      } else {
        throw Exception('failedto load');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
