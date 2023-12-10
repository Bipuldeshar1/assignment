import 'package:flutter/material.dart';
import 'package:internship_test/models/comment_model.dart';
import 'package:internship_test/models/post_model.dart';

import 'package:internship_test/network/base_api_service.dart';
import 'package:internship_test/network/network_api_service.dart';
import 'package:internship_test/utils/colors.dart';
import 'package:internship_test/utils/size.dart';

class PostDetailScreen extends StatefulWidget {
  PostModel postModel;
  PostDetailScreen({
    required this.postModel,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final cmtcontroller = TextEditingController();
  BaseApiServices _apiServices = NetworkService();

  @override
  Widget build(BuildContext context) {
    TextSizes textSizes = TextSizes();
    AppThemes appThemes = AppThemes();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postModel.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.postModel.body,
              style: TextStyle(fontSize: textSizes.mediumTextSize),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Comments',
                  style: TextStyle(
                      fontSize: textSizes.largeTextSize,
                      fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  title: Text('Add cmt'),
                                  content: TextField(
                                    controller: cmtcontroller,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _apiServices
                                            .getPostApiResponse(
                                                widget.postModel.id,
                                                widget.postModel.title,
                                                widget.postModel.title,
                                                cmtcontroller.text.toString())
                                            .then((value) =>
                                                Navigator.pop(context));
                                      },
                                      child: Text('add'),
                                    )
                                  ]));
                    },
                    child: Text('add cmt'))
              ],
            ),
          ),
          FutureBuilder<List<CommentModel>>(
            future: _apiServices.getGetApiRes(widget.postModel.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            tileColor: appThemes.secondaryColor,
                            title: Text(
                              snapshot.data![index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: textSizes.mediumTextSize,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              snapshot.data![index].body,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
