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
  final String mapsUrl;
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
    required this.mapsUrl,
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
  final String venue;
  final String mapsUrl;

  const Headliner({
    required this.name,
    required this.genre,
    required this.day,
    required this.date,
    required this.imageUrl,
    required this.description,
    required this.time,
    required this.venue,
    required this.mapsUrl,
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

class Canteen {
  final String name;
  final String location;
  final String mapsUrl;
  final String bestVeg;
  final String bestNonVeg;
  final String? description;
  final String? websiteUrl;

  const Canteen({
    required this.name,
    required this.location,
    required this.mapsUrl,
    required this.bestVeg,
    required this.bestNonVeg,
    this.description,
    this.websiteUrl,
  });
}

class Shop {
  final String name;
  final String location;
  final String mapsUrl;
  final String type;
  final String? description;

  const Shop({
    required this.name,
    required this.location,
    required this.mapsUrl,
    required this.type,
    this.description,
  });
}

class FamousSpot {
  final String name;
  final String description;
  final String mapsUrl;
  final IconData icon;

  const FamousSpot({
    required this.name,
    required this.description,
    required this.mapsUrl,
    required this.icon,
  });
}

class MedicalFacility {
  final String name;
  final String type;
  final String location;
  final String mapsUrl;
  final bool isEmergency;
  final bool isExternal;

  const MedicalFacility({
    required this.name,
    required this.type,
    required this.location,
    required this.mapsUrl,
    this.isEmergency = false,
    this.isExternal = false,
  });
}

class TeamMember {
  final String name;
  final String role;
  final String phone;
  final String? instagram;
  final String? linkedin;
  final String imageUrl;

  const TeamMember({
    required this.name,
    required this.role,
    required this.phone,
    this.instagram,
    this.linkedin,
    required this.imageUrl,
  });
}
