class Post {
  final String id;
  final String content;
  final String author;
  final String imageUrl;

  Post({required this.id, required this.content, required this.author, required this.imageUrl});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      content: json['content'],
      author: json['author'],
      imageUrl: json['imageUrl'],
    );
  }
}
