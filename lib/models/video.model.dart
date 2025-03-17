class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final DateTime createdAt;

  Video({required this.id, required this.title, required this.thumbnailUrl, required this.createdAt});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnail_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
