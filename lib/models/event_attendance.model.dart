class EventAttendance {
  final String eventId;
  final String userId;

  EventAttendance({required this.eventId, required this.userId});

  EventAttendance.fromJson({required Map<String, dynamic> json})
    : eventId = json['event_id'],
      userId = json['profile_id'];
}
