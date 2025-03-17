class Post {
  final String id;
  final String headline;
  final String content;
  final DateTime createdAt;
  final String createdBy;
  final String featuredImage;

  Post({
    required this.id,
    required this.headline,
    required this.content,
    required this.createdAt,
    required this.createdBy,
    required this.featuredImage,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      headline: json['headline'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      createdBy: json['created_by'],
      featuredImage: json['featured_image'],
    );
  }
}