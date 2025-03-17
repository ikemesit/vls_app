// Events Provider
import 'package:flutter/material.dart';
import 'package:vls_app/models/event_attendance.model.dart';

import '../models/event.model.dart';
import '../services/event.service.dart';

class EventsProvider with ChangeNotifier {
  final EventsService _service = EventsService();
  List<Event> _events = [];
  Event? _selectedEvent;
  EventAttendance? _eventAttendance;

  bool _isLoading = false;

  List<Event> get events => _events;

  Event? get selectedEvent => _selectedEvent;

  EventAttendance? get attendance => _eventAttendance;

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

  Future<void> refreshEvents() async {
    await fetchEvents(); // Method to refresh the list
  }

  Future<void> confirmEventAttendance(String eventId, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _service.confirmEventAttendance(eventId, userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to confirm attendance: $e');
    }
  }

  Future<void> fetchEventAttendanceByUserId(
    String eventId,
    String userId,
  ) async {
    // _isLoading = true;
    notifyListeners();

    try {
      _eventAttendance = await _service.fetchEventAttendanceByUserId(
        eventId,
        userId,
      );
      // _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to fetch event attendance: $e');
    }
  }
}
