class Author {
  final String id;
  final String username;
  final String email;
  final String? bio;
  final String? profileImage;

  Author({
    required this.id,
    required this.username,
    required this.email,
    this.bio,
    this.profileImage,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      bio: json['bio'],
      profileImage: json['profileImage'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'bio': bio,
      'profileImage': profileImage,
    };
  }
}
