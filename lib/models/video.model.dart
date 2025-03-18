class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String url;
  final DateTime createdAt;

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.url,
    required this.createdAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnail_url'],
      url: json['url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
