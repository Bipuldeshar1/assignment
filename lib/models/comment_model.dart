class CommentModel {
  int postid;
  int id;
  String name;
  String email;
  String body;

  CommentModel({
    required this.postid,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  CommentModel.fromJson(Map<String, dynamic> data)
      : postid = data['postId'] as int,
        id = data['id'] as int,
        name = data['name'] as String,
        email = data['email'] as String,
        body = data['body'] as String;

  Map<String, dynamic> toJson() => {
        'postId': postid,
        'id': id,
        'name': name,
        'email': email,
        'body': body,
      };
}
