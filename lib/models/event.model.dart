class Event {
  final String id;
  final String headline;
  final String description;
  final DateTime date;
  final DateTime datePosted;
  final List<String> images;

  Event({
    required this.id,
    required this.headline,
    required this.description,
    required this.date,
    required this.datePosted,
    required this.images,
  });

  Event.fromJson({required Map<String, dynamic> json})
    : id = json['id'],
      headline = json['headline'],
      description = json['description'],
      date = DateTime.parse(json['date']),
      datePosted = DateTime.parse(json['date_posted']),
      images = List<String>.from(json['images'] ?? []);
}
