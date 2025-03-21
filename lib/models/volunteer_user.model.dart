class VolunteerUser {
  final int id;
  final String adId;
  final String userId;

  VolunteerUser({required this.id, required this.adId, required this.userId});

  factory VolunteerUser.fromJson(Map<String, dynamic> json) {
    return VolunteerUser(
      id: json['id'],
      adId: json['ad_id'],
      userId: json['user_id'],
    );
  }
}
