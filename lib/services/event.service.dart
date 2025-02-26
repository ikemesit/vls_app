import 'package:supabase_flutter/supabase_flutter.dart';

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
}
