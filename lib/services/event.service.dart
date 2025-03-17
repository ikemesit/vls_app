import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vls_app/models/event_attendance.model.dart';

import '../models/event.model.dart';

class EventsService {
  final supabase = Supabase.instance.client;

  Future<List<Event>> getAllEvents() async {
    final response = await supabase
        .from('events')
        .select()
        .order('date_posted', ascending: false);

    return (response as List)
        .map((data) => Event.fromJson(json: data))
        .toList();
  }

  Future<Event?> getEventById(String id) async {
    final response =
        await supabase.from('events').select().eq('id', id).single();

    return Event.fromJson(json: response);
  }

  Future<void> confirmEventAttendance(String eventId, String userId) async {
    try {
      await supabase.from('event_attendees').insert({
        'event_id': eventId,
        'profile_id': userId,
      });
    } catch (e) {
      throw Exception('Failed to confirm attendance: $e');
    }
  }

  Future<EventAttendance> fetchEventAttendanceByUserId(
    String eventId,
    String userId,
  ) async {
    try {
      final response =
          await supabase
              .from('event_attendees')
              .select()
              .eq('event_id', eventId)
              .eq('profile_id', userId)
              .single();

      print(response);

      return EventAttendance.fromJson(json: response);
    } catch (e) {
      throw Exception('Failed to fetch event attendance: $e');
    }
  }
}
