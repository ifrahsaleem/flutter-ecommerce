class Comment {

  final bool approved;
  final String commentID, commentContent, user;
  final int rating, v;

  Comment({this.approved, this.commentID, this.commentContent, this.user, this.rating, this.v});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      approved: json['approved'],
      commentID: json['_id'],
      commentContent: json['content'],
      rating: json['rating'],
      user: json['user'],
      v: json['__v'],
    );
  }

}
