class VolunteerAd {
  final int id;
  final String title;
  final String description;
  final DateTime expiresAt;
  final DateTime createdAt;

  VolunteerAd({
    required this.id,
    required this.title,
    required this.description,
    required this.expiresAt,
    required this.createdAt,
  });

  factory VolunteerAd.fromJson(Map<String, dynamic> json) {
    return VolunteerAd(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      expiresAt: DateTime.parse(json['expires_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
