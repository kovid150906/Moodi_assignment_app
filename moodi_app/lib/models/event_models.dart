import 'package:flutter/material.dart';

/// Data models for Mood Indigo 2025 content

class EventCategory {
  final String name;
  final IconData icon;
  final Color color;
  final String description;
  final List<Event> events;

  const EventCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
    required this.events,
  });
}

class Event {
  final String title;
  final String subtitle;
  final String description;
  final String date;
  final String time;
  final String venue;
  final String imageUrl;
  final EventType type;
  final List<String> tags;

  const Event({
    required this.title,
    this.subtitle = '',
    required this.description,
    required this.date,
    required this.time,
    required this.venue,
    required this.imageUrl,
    required this.type,
    this.tags = const [],
  });
}

enum EventType { concert, proshow, competition, workshop, humorFest, imf, worldFiesta }

class Headliner {
  final String name;
  final String genre;
  final String day;
  final String date;
  final String imageUrl;
  final String description;
  final String time;

  const Headliner({
    required this.name,
    required this.genre,
    required this.day,
    required this.date,
    required this.imageUrl,
    required this.description,
    required this.time,
  });
}

class TimelineEntry {
  final String year;
  final String title;
  final String description;
  final IconData icon;

  const TimelineEntry({
    required this.year,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class FestStat {
  final String label;
  final String value;
  final IconData icon;

  const FestStat({
    required this.label,
    required this.value,
    required this.icon,
  });
}

class Sponsor {
  final String name;
  final String category;
  final String logoUrl;

  const Sponsor({
    required this.name,
    required this.category,
    required this.logoUrl,
  });
}
