class Video {
  final String id;
  final String title;
  final String thumbnailUrl;

  Video({required this.id, required this.title, required this.thumbnailUrl});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
