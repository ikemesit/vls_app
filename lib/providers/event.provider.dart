// Events Provider
import 'package:flutter/material.dart';

import '../models/event.model.dart';
import '../services/event.service.dart';

class EventsProvider with ChangeNotifier {
  final EventsService _service = EventsService();
  List<Event> _events = [];
  Event? _selectedEvent;
  bool _isLoading = false;

  List<Event> get events => _events;

  Event? get selectedEvent => _selectedEvent;

  bool get isLoading => _isLoading;

  EventsProvider() {
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    _isLoading = true;
    notifyListeners();

    try {
      _events = await _service.getAllEvents();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load events: $e');
    }
  }

  Future<void> fetchEventById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedEvent = await _service.getEventById(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load event: $e');
    }
  }
}
