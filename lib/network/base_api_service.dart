import 'package:internship_test/models/comment_model.dart';
import 'package:internship_test/models/post_model.dart';

abstract class BaseApiServices {
  Future<List<PostModel>> getGetApiResponse();

  Future<List<CommentModel>> getGetApiRes(int id);

  Future<CommentModel> getPostApiResponse(
      int postId, String name, String email, String body);
}
