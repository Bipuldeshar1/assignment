import 'package:flutter/material.dart';
import 'package:internship_test/models/post_model.dart';

import 'package:internship_test/network/base_api_service.dart';
import 'package:internship_test/network/network_api_service.dart';
import 'package:internship_test/screens/post_detail_screen.dart';
import 'package:internship_test/utils/colors.dart';
import 'package:internship_test/utils/size.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  BaseApiServices _apiServices = NetworkService();
  TextSizes textSizes = TextSizes();
  AppThemes appThemes = AppThemes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('post'),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: _apiServices.getGetApiResponse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    tileColor: appThemes.secondaryColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailScreen(
                            postModel: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                    title: Text(
                      snapshot.data![index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: textSizes.mediumTextSize,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      snapshot.data![index].body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            );
          } else {
            return Text('no data');
          }
        },
      ),
    );
  }
}
