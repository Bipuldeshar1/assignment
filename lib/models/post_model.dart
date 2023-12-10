class PostModel {
  int id;
  int userid;
  String title;
  String body;
  PostModel({
    required this.id,
    required this.userid,
    required this.title,
    required this.body,
  });

  PostModel.fromJson(Map<String, dynamic> data)
      : id = data['id'] as int,
        userid = data['userId'] as int,
        title = data['title'] as String,
        body = data['body'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userid,
        'title': title,
        'body': body,
      };
}
