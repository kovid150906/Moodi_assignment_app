import 'package:flutter/material.dart';
import '../models/event_models.dart';

/// Static data for Mood Indigo 2025
/// Theme: "A Vortex of Vandalism"
/// Dates: December 15-18, 2025
/// Venue: IIT Bombay, Mumbai

class MoodiData {
  MoodiData._();

  // ==================== FEST INFO ====================
  static const String festName = 'MOOD INDIGO';
  static const String festYear = '2025';
  static const String festTheme = 'A Vortex of Vandalism';
  static const String festTagline =
      'Step into the Vortex of Vandalism, where the polite silence of the norm '
      'is shattered by the raw, electric roar of rebellion.';
  static const String festDescription =
      'Mood Indigo is Asia\'s largest college cultural festival, organized by '
      'the students of IIT Bombay. Founded in 1971, it has grown into a '
      'multi-day celebration of music, art, dance, literature, and innovation - '
      'attracting 1,50,000+ visitors annually.';
  static const String festDates = 'December 15 - 18, 2025';
  static const String festVenue = 'IIT Bombay, Powai, Mumbai';

  // ==================== STATS ====================
  static const List<FestStat> stats = [
    FestStat(
      label: 'Footfall',
      value: '1,50,000+',
      icon: Icons.people_alt_rounded,
    ),
    FestStat(
      label: 'Intl Artists',
      value: '1,000+',
      icon: Icons.music_note_rounded,
    ),
    FestStat(
      label: 'Events',
      value: '240+',
      icon: Icons.event_rounded,
    ),
    FestStat(
      label: 'Colleges',
      value: '4,000+',
      icon: Icons.school_rounded,
    ),
  ];

  // ==================== HEADLINERS ====================
  static const List<Headliner> headliners = [
    Headliner(
      name: 'Sonu Nigam',
      genre: 'Bollywood | Playback',
      day: 'Day 1',
      date: 'December 15',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800',
      description:
          'The legendary voice behind countless Bollywood chartbusters, '
          'Sonu Nigam returns to the Mood Indigo stage for an unforgettable '
          'Pronite performance.',
      time: '9:00 PM onwards',
      venue: 'Gymkhana Grounds',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay',
    ),
    Headliner(
      name: 'Dhruv Visvanath',
      genre: 'Indie | Acoustic | Singer-Songwriter',
      day: 'Day 2',
      date: 'December 16',
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
      description:
          'Award-winning indie musician and guitarist, Dhruv Visvanath '
          'brings his signature soulful melodies and masterful guitar '
          'work to Mood Indigo 2025.',
      time: '8:30 PM onwards',
      venue: 'Gymkhana Grounds',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay',
    ),
    Headliner(
      name: 'Shankar Mahadevan',
      genre: 'Classical | Bollywood | Fusion',
      day: 'Day 3',
      date: 'December 17',
      imageUrl: 'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?w=800',
      description:
          'One-third of the iconic Shankar-Ehsaan-Loy trio, Shankar '
          'Mahadevan takes the stage with his breathtaking vocal range '
          'and electrifying live performances.',
      time: '9:00 PM onwards',
      venue: 'Gymkhana Grounds',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay',
    ),
    Headliner(
      name: 'Comedy Night Special',
      genre: 'Stand-Up | Humor Fest',
      day: 'Day 4',
      date: 'December 18',
      imageUrl: 'https://images.unsplash.com/photo-1527224857830-43a7acc85260?w=800',
      description:
          'The grand closing night features India\'s top comedians in '
          'an epic humor fest that will leave you in splits. '
          'A fitting finale to four days of cultural chaos!',
      time: '8:00 PM onwards',
      venue: 'Gymkhana Grounds',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay',
    ),
  ];

  // ==================== EVENT CATEGORIES ====================
  static const List<EventCategory> categories = [
    EventCategory(
      name: 'Concerts',
      icon: Icons.music_note_rounded,
      color: Color(0xFFFF2D55),
      description: 'Pronites featuring national & international artists',
      events: _concertEvents,
    ),
    EventCategory(
      name: 'Proshows',
      icon: Icons.star_rounded,
      color: Color(0xFFBB86FC),
      description: 'Professional performances & celebrity acts',
      events: _proshowEvents,
    ),
    EventCategory(
      name: 'Humor Fest',
      icon: Icons.sentiment_very_satisfied_rounded,
      color: Color(0xFFFFEA00),
      description: 'Stand-up comedy and humor events',
      events: _humorEvents,
    ),
    EventCategory(
      name: 'IMF',
      icon: Icons.public_rounded,
      color: Color(0xFF00E5FF),
      description: 'International Music Festival - global beats',
      events: _imfEvents,
    ),
    EventCategory(
      name: 'World Fiesta',
      icon: Icons.celebration_rounded,
      color: Color(0xFFFF6B8A),
      description: 'Cultural exchange with international delegations',
      events: _worldFiestaEvents,
    ),
    EventCategory(
      name: 'Workshops',
      icon: Icons.build_rounded,
      color: Color(0xFF00E676),
      description: 'Hands-on learning experiences with industry pros',
      events: _workshopEvents,
    ),
  ];

  // ==================== CONCERTS ====================
  static const List<Event> _concertEvents = [
    Event(
      title: 'Sonu Nigam Live',
      subtitle: 'Pronite Day 1',
      description:
          'The voice behind "Kal Ho Naa Ho", "Suraj Hua Maddham" and hundreds '
          'more delivers a powerhouse Bollywood night.',
      date: 'Dec 15',
      time: '9:00 PM',
      venue: 'Gymkhana Grounds',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800',
      type: EventType.concert,
      tags: ['Bollywood', 'Playback', 'Headliner'],
    ),
    Event(
      title: 'Dhruv Visvanath',
      subtitle: 'Pronite Day 2',
      description:
          'India\'s premier indie musician with soulful guitar compositions.',
      date: 'Dec 16',
      time: '8:30 PM',
      venue: 'Gymkhana Grounds',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
      type: EventType.concert,
      tags: ['Indie', 'Acoustic', 'Live'],
    ),
    Event(
      title: 'Shankar Mahadevan Live',
      subtitle: 'Pronite Day 3',
      description:
          'Breathless, Mitwa, Dil Chahta Hai - experience the magic live.',
      date: 'Dec 17',
      time: '9:00 PM',
      venue: 'Gymkhana Grounds',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?w=800',
      type: EventType.concert,
      tags: ['Bollywood', 'Classical', 'Fusion'],
    ),
    Event(
      title: 'Battle of Bands - Livewire',
      subtitle: 'Rock it out',
      description:
          'Nationwide rock band competition. The biggest college-level '
          'band battle in India. Preliminary rounds across 4 cities.',
      date: 'Dec 15-17',
      time: '4:00 PM',
      venue: 'Open Air Theatre',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Open+Air+Theatre+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=800',
      type: EventType.concert,
      tags: ['Rock', 'Competition', 'Bands'],
    ),
  ];

  // ==================== PROSHOWS ====================
  static const List<Event> _proshowEvents = [
    Event(
      title: 'EDM Night',
      subtitle: 'Electronic Dance Music',
      description:
          'High-energy EDM night with top DJs spinning tracks under the stars. '
          'Laser lights, fog machines, and pure bass.',
      date: 'Dec 16',
      time: '10:00 PM',
      venue: 'Ground Stage',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Ground+Stage+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1574375927938-d5a98e8ffe85?w=800',
      type: EventType.proshow,
      tags: ['EDM', 'DJs', 'Party'],
    ),
    Event(
      title: 'Classical Jugalbandi',
      subtitle: 'Indian Classical Night',
      description:
          'A mesmerizing evening of Indian classical music featuring tabla, '
          'sitar, and vocal performances.',
      date: 'Dec 17',
      time: '6:00 PM',
      venue: 'Convocation Hall',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Convocation+Hall+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?w=800',
      type: EventType.proshow,
      tags: ['Classical', 'Traditional', 'Fusion'],
    ),
  ];

  // ==================== HUMOR FEST ====================
  static const List<Event> _humorEvents = [
    Event(
      title: 'Stand-Up Smackdown',
      subtitle: 'Humor Fest Finale',
      description:
          'India\'s top comedians deliver an evening of gut-busting '
          'laughter. Open mic rounds followed by headline acts.',
      date: 'Dec 18',
      time: '8:00 PM',
      venue: 'Gymkhana Grounds',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1527224857830-43a7acc85260?w=800',
      type: EventType.humorFest,
      tags: ['Comedy', 'Stand-Up', 'Headline'],
    ),
    Event(
      title: 'Improv Night',
      subtitle: 'Unscripted Chaos',
      description:
          'Improvisational comedy where the audience controls the show.',
      date: 'Dec 16',
      time: '6:00 PM',
      venue: 'LT-101',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=LT+101+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1527224857830-43a7acc85260?w=800',
      type: EventType.humorFest,
      tags: ['Improv', 'Interactive', 'Fun'],
    ),
  ];

  // ==================== IMF ====================
  static const List<Event> _imfEvents = [
    Event(
      title: 'International Music Festival',
      subtitle: 'Global Beats, One Stage',
      description:
          'Bands and artists from across the globe come together for '
          'a celebration of world music at IIT Bombay.',
      date: 'Dec 15-17',
      time: '3:00 PM',
      venue: 'Open Air Theatre',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Open+Air+Theatre+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800',
      type: EventType.imf,
      tags: ['International', 'World Music', 'Fusion'],
    ),
    Event(
      title: 'Jazz & Blues Evening',
      subtitle: 'Smooth Vibes',
      description:
          'An intimate evening of jazz and blues from international '
          'and Indian artists.',
      date: 'Dec 16',
      time: '5:00 PM',
      venue: 'FC Kohli Auditorium',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=FC+Kohli+Auditorium+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1511192336575-5a79af67a629?w=800',
      type: EventType.imf,
      tags: ['Jazz', 'Blues', 'Chill'],
    ),
  ];

  // ==================== WORLD FIESTA ====================
  static const List<Event> _worldFiestaEvents = [
    Event(
      title: 'Cultural Carnival',
      subtitle: 'A World in One Campus',
      description:
          'International delegations showcase their culture, food, and art. '
          'Countries from 5 continents participate.',
      date: 'Dec 15-18',
      time: 'All Day',
      venue: 'Central Lawn',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Central+Lawn+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=800',
      type: EventType.worldFiesta,
      tags: ['Culture', 'Food', 'International'],
    ),
    Event(
      title: 'World Dance Championship',
      subtitle: 'Move Without Borders',
      description:
          'Dance crews from around the world compete in styles ranging '
          'from K-Pop to Salsa to B-Boying.',
      date: 'Dec 17',
      time: '2:00 PM',
      venue: 'Ground Stage',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Ground+Stage+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1535525153412-5a42439a210d?w=800',
      type: EventType.worldFiesta,
      tags: ['Dance', 'Competition', 'International'],
    ),
  ];

  // ==================== WORKSHOPS ====================
  static const List<Event> _workshopEvents = [
    Event(
      title: 'Music Production 101',
      subtitle: 'By Furtados School of Music',
      description:
          'Learn the basics of digital music production, DAWs, '
          'mixing, and mastering from industry professionals.',
      date: 'Dec 15',
      time: '10:00 AM',
      venue: 'SOM Seminar Hall',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=SOM+Seminar+Hall+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?w=800',
      type: EventType.workshop,
      tags: ['Music', 'Production', 'Hands-On'],
    ),
    Event(
      title: 'Street Art & Graffiti',
      subtitle: 'Vandalism as Art',
      description:
          'Spray-can graffiti, stencil art, and urban sketching workshop '
          'aligned with this year\'s theme.',
      date: 'Dec 16',
      time: '11:00 AM',
      venue: 'Design Centre',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Design+Centre+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1561059488-916d69792237?w=800',
      type: EventType.workshop,
      tags: ['Art', 'Graffiti', 'Creative'],
    ),
    Event(
      title: 'Stand-Up Comedy Workshop',
      subtitle: 'Nerds of Comedy',
      description:
          'Craft your first 5-minute set with guidance from professional '
          'comedians. Open to all experience levels.',
      date: 'Dec 17',
      time: '2:00 PM',
      venue: 'LT-003',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=LT+003+IIT+Bombay',
      imageUrl: 'https://images.unsplash.com/photo-1585699324551-f6c309eedeca?w=800',
      type: EventType.workshop,
      tags: ['Comedy', 'Writing', 'Performance'],
    ),
  ];

  // ==================== TIMELINE ====================
  static const List<TimelineEntry> timeline = [
    TimelineEntry(
      year: '1971',
      title: 'The Beginning',
      description:
          'First Mood Indigo with a budget of Rs. 5,000. Named after '
          'Duke Ellington\'s jazz piece.',
      icon: Icons.auto_awesome,
    ),
    TimelineEntry(
      year: '1981',
      title: 'Legends on Stage',
      description:
          'Asha Bhosle & R D Burman perform at the Indian Music Night.',
      icon: Icons.music_note_rounded,
    ),
    TimelineEntry(
      year: '2008',
      title: 'First International Nite',
      description:
          'Finnish metal band Ensiferum performs - MI goes international.',
      icon: Icons.public_rounded,
    ),
    TimelineEntry(
      year: '2009',
      title: 'Porcupine Tree in India',
      description:
          'Progressive rock legends play their first-ever India concert at MI.',
      icon: Icons.album_rounded,
    ),
    TimelineEntry(
      year: '2011',
      title: 'Limca World Record',
      description:
          'Most international artists at any college festival. Karnivool\'s '
          'India debut.',
      icon: Icons.emoji_events_rounded,
    ),
    TimelineEntry(
      year: '2012',
      title: 'Simple Plan Headline',
      description:
          'Canadian punk rock band Simple Plan headlines MI. First '
          'international carnival.',
      icon: Icons.celebration_rounded,
    ),
    TimelineEntry(
      year: '2019',
      title: 'Golden Jubilee',
      description:
          '50 glorious years of Mood Indigo celebrated with record attendance.',
      icon: Icons.star_rounded,
    ),
    TimelineEntry(
      year: '2025',
      title: 'Vortex of Vandalism',
      description:
          'The punk-fueled rebellion descends - tearing apart convention '
          'with raw energy and electric chaos.',
      icon: Icons.bolt_rounded,
    ),
  ];

  // ==================== SCHEDULE ====================
  static const List<Map<String, dynamic>> schedule = [
    {
      'day': 'Day 1',
      'date': 'December 15',
      'dayLabel': 'MON',
      'events': [
        {'time': '10:00 AM', 'title': 'Fest Inauguration', 'venue': 'Convocation Hall', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Convocation+Hall+IIT+Bombay'},
        {'time': '11:00 AM', 'title': 'Music Production Workshop', 'venue': 'SOM Hall', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=SOM+Seminar+Hall+IIT+Bombay'},
        {'time': '2:00 PM', 'title': 'Livewire Round 1', 'venue': 'Open Air Theatre', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Open+Air+Theatre+IIT+Bombay'},
        {'time': '3:00 PM', 'title': 'IMF - World Music', 'venue': 'OAT', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Open+Air+Theatre+IIT+Bombay'},
        {'time': '5:00 PM', 'title': 'Cultural Carnival Begins', 'venue': 'Central Lawn', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Central+Lawn+IIT+Bombay'},
        {'time': '9:00 PM', 'title': 'PRONITE - Sonu Nigam', 'venue': 'Gymkhana Grounds', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay'},
      ],
    },
    {
      'day': 'Day 2',
      'date': 'December 16',
      'dayLabel': 'TUE',
      'events': [
        {'time': '10:00 AM', 'title': 'Art Competitions', 'venue': 'Design Centre', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Design+Centre+IIT+Bombay'},
        {'time': '11:00 AM', 'title': 'Street Art Workshop', 'venue': 'Design Centre', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Design+Centre+IIT+Bombay'},
        {'time': '2:00 PM', 'title': 'Livewire Round 2', 'venue': 'OAT', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Open+Air+Theatre+IIT+Bombay'},
        {'time': '5:00 PM', 'title': 'Jazz & Blues Evening', 'venue': 'FC Kohli', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=FC+Kohli+Auditorium+IIT+Bombay'},
        {'time': '6:00 PM', 'title': 'Improv Night', 'venue': 'LT-101', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=LT+101+IIT+Bombay'},
        {'time': '8:30 PM', 'title': 'PRONITE - Dhruv Visvanath', 'venue': 'Gymkhana Grounds', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay'},
        {'time': '10:00 PM', 'title': 'EDM Night', 'venue': 'Ground Stage', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Ground+Stage+IIT+Bombay'},
      ],
    },
    {
      'day': 'Day 3',
      'date': 'December 17',
      'dayLabel': 'WED',
      'events': [
        {'time': '10:00 AM', 'title': 'Dance Competitions', 'venue': 'SAC', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=SAC+IIT+Bombay'},
        {'time': '2:00 PM', 'title': 'World Dance Championship', 'venue': 'Ground Stage', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Ground+Stage+IIT+Bombay'},
        {'time': '2:00 PM', 'title': 'Comedy Workshop', 'venue': 'LT-003', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=LT+003+IIT+Bombay'},
        {'time': '4:00 PM', 'title': 'Livewire Finals', 'venue': 'OAT', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Open+Air+Theatre+IIT+Bombay'},
        {'time': '6:00 PM', 'title': 'Classical Jugalbandi', 'venue': 'Convo Hall', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Convocation+Hall+IIT+Bombay'},
        {'time': '9:00 PM', 'title': 'PRONITE - Shankar Mahadevan', 'venue': 'Gymkhana Grounds', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay'},
      ],
    },
    {
      'day': 'Day 4',
      'date': 'December 18',
      'dayLabel': 'THU',
      'events': [
        {'time': '10:00 AM', 'title': 'LitFest Panels', 'venue': 'FC Kohli', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=FC+Kohli+Auditorium+IIT+Bombay'},
        {'time': '12:00 PM', 'title': 'Photography Walk', 'venue': 'Campus', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=IIT+Bombay+Campus'},
        {'time': '3:00 PM', 'title': 'Fashion Show - SGTL', 'venue': 'SAC', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=SAC+IIT+Bombay'},
        {'time': '5:00 PM', 'title': 'Award Ceremonies', 'venue': 'Convo Hall', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Convocation+Hall+IIT+Bombay'},
        {'time': '8:00 PM', 'title': 'HUMOR FEST - Grand Finale', 'venue': 'Gymkhana Grounds', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay'},
        {'time': '10:00 PM', 'title': 'Closing Ceremony', 'venue': 'Gymkhana Grounds', 'mapsUrl': 'https://www.google.com/maps/search/?api=1&query=Gymkhana+Grounds+IIT+Bombay'},
      ],
    },
  ];

  // ==================== SPONSORS ====================
  static const List<Sponsor> sponsors = [
    Sponsor(name: 'POP UPI', category: 'Title Sponsor', logoUrl: ''),
    Sponsor(name: 'House of Google AI', category: 'AI Partner', logoUrl: ''),
    Sponsor(name: 'Royal Enfield Hunter 350', category: 'Driven By Partner', logoUrl: ''),
    Sponsor(name: 'Cantabil International', category: 'Clothing Associate', logoUrl: ''),
    Sponsor(name: 'Coca-Cola', category: 'Beverage Partner', logoUrl: ''),
    Sponsor(name: 'Furtados', category: 'Concert Gear Partner', logoUrl: ''),
    Sponsor(name: 'BIG FM', category: 'Radio Partner', logoUrl: ''),
    Sponsor(name: 'Outlet Mall of India', category: 'Shopping Partner', logoUrl: ''),
  ];

  // ==================== EATERIES & CANTEENS ====================
  static const List<Canteen> canteens = [
    Canteen(
      name: 'Aromas Canteen',
      location: 'Near Main Gate',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Aromas+Canteen+IIT+Bombay',
      bestVeg: 'Paneer Butter Masala with Naan',
      bestNonVeg: 'Chicken Biryani',
      description: 'One of the most popular canteens with a wide variety of North Indian dishes.',
      websiteUrl: 'https://aromasiitb.com/',
    ),
    Canteen(
      name: 'H2 Canteen',
      location: 'Hostel 2',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hostel+2+IIT+Bombay',
      bestVeg: 'Chole Bhature',
      bestNonVeg: 'Egg Curry with Rice',
      description: 'Known for quick service and delicious parathas.',
      websiteUrl: 'https://h2iitbombay.com/',
    ),
    Canteen(
      name: 'H3 Canteen',
      location: 'Hostel 3',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hostel+3+IIT+Bombay',
      bestVeg: 'Pav Bhaji',
      bestNonVeg: 'Chicken Fried Rice',
      description: 'Late-night favorite for students.',
    ),
    Canteen(
      name: 'Amul Canteen',
      location: 'Hostel 5',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hostel+5+IIT+Bombay',
      bestVeg: 'Masala Dosa',
      bestNonVeg: 'Chicken Tikka',
      description: 'Fresh dairy products and South Indian specialties.',
    ),
    Canteen(
      name: 'H12 Canteen',
      location: 'Hostel 6',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hostel+6+IIT+Bombay',
      bestVeg: 'Veg Thali',
      bestNonVeg: 'Fish Curry',
      description: 'Homestyle comfort food.',
    ),
    Canteen(
      name: 'Cafe 9Tea7',
      location: 'Hostel 7 & H21 (Connected)',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hostel+7+IIT+Bombay',
      bestVeg: 'Grilled Sandwich',
      bestNonVeg: 'Chicken Sandwich',
      description: 'Trendy cafe with snacks and beverages.',
    ),
    Canteen(
      name: 'Cafe 92',
      location: 'Near SAC',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Cafe+92+IIT+Bombay',
      bestVeg: 'Pasta Arrabiata',
      bestNonVeg: 'Chicken Burger',
      description: 'Modern cafe with continental options.',
    ),
    Canteen(
      name: 'CCD (Cafe Coffee Day)',
      location: 'Near Main Building',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=CCD+IIT+Bombay',
      bestVeg: 'Veg Pizza',
      bestNonVeg: 'Chicken Wrap',
      description: 'Coffee and quick bites.',
    ),
    Canteen(
      name: 'Chayos',
      location: 'Student Activity Center',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Chayos+SAC+IIT+Bombay',
      bestVeg: 'Veg Momos',
      bestNonVeg: 'Chicken Momos',
      description: 'Popular for chai, snacks, and momos.',
    ),
    Canteen(
      name: 'Quantum Cafe',
      location: 'Rahul Bajaj Building',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Rahul+Bajaj+Building+IIT+Bombay',
      bestVeg: 'Margherita Pizza',
      bestNonVeg: 'BBQ Chicken Pizza',
      description: 'Cozy cafe in the management building.',
    ),
    Canteen(
      name: 'Gulmohar',
      location: 'Near Faculty Housing',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Gulmohar+Restaurant+IIT+Bombay',
      bestVeg: 'Palak Paneer',
      bestNonVeg: 'Butter Chicken',
      description: 'Fine dining experience within campus.',
    ),
    Canteen(
      name: 'Dominos',
      location: 'IIT Bombay Campus',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Dominos+IIT+Bombay',
      bestVeg: 'Farmhouse Pizza',
      bestNonVeg: 'Peppy Paneer Pizza',
      description: 'Everyone\'s favorite pizza chain.',
    ),
  ];

  // ==================== SHOPS ====================
  static const List<Shop> shops = [
    Shop(
      name: 'H16 Shop',
      location: 'Hostel 16',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hostel+16+IIT+Bombay',
      type: 'General Store',
      description: 'Daily essentials, snacks, and stationery.',
    ),
    Shop(
      name: 'H1 Shop',
      location: 'Hostel 1',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hostel+1+IIT+Bombay',
      type: 'General Store',
      description: 'Groceries and convenience items.',
    ),
    Shop(
      name: 'H2 Shop',
      location: 'Hostel 2',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hostel+2+IIT+Bombay',
      type: 'General Store',
      description: 'Snacks, beverages, and daily needs.',
    ),
    Shop(
      name: 'H3 Shop',
      location: 'Hostel 3',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hostel+3+IIT+Bombay',
      type: 'General Store',
      description: 'Late-night shopping for essentials.',
    ),
    Shop(
      name: 'H5 Shop',
      location: 'Hostel 5',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hostel+5+IIT+Bombay',
      type: 'General Store',
      description: 'Stationery, snacks, and toiletries.',
    ),
    Shop(
      name: 'H18 Shop',
      location: 'Hostel 18',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hostel+18+IIT+Bombay',
      type: 'General Store',
      description: 'Convenience store for students.',
    ),
    Shop(
      name: 'H12 Shop',
      location: 'Hostel 12',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hostel+12+IIT+Bombay',
      type: 'General Store',
      description: 'Campus essentials and snacks.',
    ),
    Shop(
      name: 'IIT Bombay Souvenir Shop',
      location: 'Near Main Gate',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=IIT+Bombay+Main+Gate',
      type: 'Souvenir Shop',
      description: 'Official IIT Bombay merchandise, T-shirts, mugs, and memorabilia.',
    ),
  ];

  // ==================== FAMOUS SPOTS ====================
  static const List<FamousSpot> famousSpots = [
    FamousSpot(
      name: 'Rahul Bajaj Terrace',
      description: 'Stunning rooftop view of the campus. Perfect spot for sunset and evening hangouts.',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Rahul+Bajaj+Building+IIT+Bombay',
      icon: Icons.terrain_rounded,
    ),
    FamousSpot(
      name: 'Energy Boat House',
      description: 'Peaceful lakeside spot with boat rides. Great for relaxation and photography.',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Boat+House+IIT+Bombay',
      icon: Icons.sailing_rounded,
    ),
    FamousSpot(
      name: 'Sammer Hills',
      description: 'Scenic hilltop location with panoramic views of the campus and Powai Lake.',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Sammer+Hills+IIT+Bombay',
      icon: Icons.landscape_rounded,
    ),
    FamousSpot(
      name: 'Infinite Corridor',
      description: 'The iconic endless hallway connecting academic buildings. A must-visit landmark.',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Infinite+Corridor+IIT+Bombay',
      icon: Icons.view_in_ar_rounded,
    ),
    FamousSpot(
      name: 'Powai Lake View Point',
      description: 'Breathtaking view of the lake from campus. Popular evening spot.',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Powai+Lake+View+IIT+Bombay',
      icon: Icons.water_rounded,
    ),
    FamousSpot(
      name: 'Main Building Lawns',
      description: 'Lush green lawns perfect for picnics, group study, and events.',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Main+Building+IIT+Bombay',
      icon: Icons.grass_rounded,
    ),
  ];

  // ==================== MEDICAL FACILITIES ====================
  static const List<MedicalFacility> medicalFacilities = [
    // IIT Bombay Facilities
    MedicalFacility(
      name: 'IIT Bombay Hospital',
      type: 'Hospital',
      location: 'Near Main Gate, IIT Bombay',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=IIT+Bombay+Hospital',
      isEmergency: true,
      isExternal: false,
    ),
    MedicalFacility(
      name: 'Campus Medical Shop',
      type: 'Pharmacy',
      location: 'Near Hospital, IIT Bombay',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Medical+Shop+IIT+Bombay',
      isEmergency: false,
      isExternal: false,
    ),
    MedicalFacility(
      name: '24/7 Emergency Care',
      type: 'Emergency',
      location: 'Hospital Building, IIT Bombay',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=IIT+Bombay+Hospital',
      isEmergency: true,
      isExternal: false,
    ),
    // Nearby External Facilities
    MedicalFacility(
      name: 'Hiranandani Hospital',
      type: 'Hospital',
      location: 'Powai, Mumbai (3.5 km)',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Hiranandani+Hospital+Powai',
      isEmergency: true,
      isExternal: true,
    ),
    MedicalFacility(
      name: 'Apollo Spectra Hospital',
      type: 'Hospital',
      location: 'Vikhroli, Mumbai (5 km)',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Apollo+Spectra+Hospital+Vikhroli',
      isEmergency: true,
      isExternal: true,
    ),
    MedicalFacility(
      name: 'Powai Medical Centre',
      type: 'Clinic',
      location: 'Powai Plaza, Mumbai (2.8 km)',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Powai+Medical+Centre',
      isEmergency: false,
      isExternal: true,
    ),
    MedicalFacility(
      name: 'Apollo Pharmacy',
      type: 'Pharmacy',
      location: 'Powai, Mumbai (2.5 km)',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Apollo+Pharmacy+Powai',
      isEmergency: false,
      isExternal: true,
    ),
    MedicalFacility(
      name: 'MedPlus Pharmacy',
      type: 'Pharmacy',
      location: 'Hiranandani, Powai (3 km)',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=MedPlus+Pharmacy+Powai',
      isEmergency: false,
      isExternal: true,
    ),
    MedicalFacility(
      name: 'Fortis Hospital',
      type: 'Hospital',
      location: 'Mulund, Mumbai (7 km)',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Fortis+Hospital+Mulund',
      isEmergency: true,
      isExternal: true,
    ),
  ];

  // ==================== MOOD INDIGO TEAM 2025 ====================
  static const List<TeamMember> teamMembers = [
    // Overall Coordinators
    TeamMember(
      name: 'Ajeet Singh Gera',
      role: 'Overall Coordinator',
      phone: '+91 62666 51003',
      instagram: 'ajeetsingh8758',
      linkedin: 'ajeet-singh-gera-bb1981255',
      imageUrl: 'assets/images/team/ajeet-Da32PKMl.jpg',
    ),
    TeamMember(
      name: 'Dhruv Gangrade',
      role: 'Overall Coordinator',
      phone: '+91 93019 38525',
      instagram: 'dhruv_gangrade3',
      linkedin: 'dhruv-gangrade-943493265',
      imageUrl: 'assets/images/team/dhruv-DRCOcHjz.jpg',
    ),
    // Competitions and LYPS
    TeamMember(
      name: 'Kuldeep Mallya',
      role: 'Competitions & LYPS',
      phone: '+91 88844 44382',
      instagram: 'kuldeepmallya',
      linkedin: 'kuldeep-mallya-250a4827a',
      imageUrl: 'assets/images/team/kuldeep-min-D78MBf12.jpg',
    ),
    TeamMember(
      name: 'Devanshi Khandelwal',
      role: 'Competitions & LYPS',
      phone: '+91 79762 57768',
      instagram: 'devanshik_005',
      linkedin: 'devanshi-khandelwal-8807ba272',
      imageUrl: 'assets/images/team/devanshi-min-DSYUcZ6N.jpg',
    ),
    // Creatives
    TeamMember(
      name: 'Vishal Tiwari',
      role: 'Creatives',
      phone: '+91 91184 46955',
      instagram: 'vishaltiwari_02_',
      linkedin: 'tiwari-vishal',
      imageUrl: 'assets/images/team/vishal-min-CMiogCR3.jpg',
    ),
    TeamMember(
      name: 'Vishwajeet Natu',
      role: 'Creatives',
      phone: '+91 99603 89919',
      instagram: 'vishwajeet._09',
      linkedin: 'vishwajeet-natu-362846299',
      imageUrl: 'assets/images/team/vishwajeet-min-CNxsunMk.png',
    ),
    TeamMember(
      name: 'Aditi Kadam',
      role: 'Creatives',
      phone: '+91 89580 88194',
      instagram: 'aditikadam_31',
      linkedin: 'aditi-kadam-7a064a354',
      imageUrl: 'assets/images/team/aditi-min-C1HECpiG.jpg',
    ),
    TeamMember(
      name: 'Kushagra Singh',
      role: 'Creatives',
      phone: '+91 83035 24849',
      instagram: 'kushagrrrrr',
      linkedin: 'kushagra-singh-958062360',
      imageUrl: 'assets/images/team/kushagra-min-BjXjrphJ.jpg',
    ),
    // Food and Beverages
    TeamMember(
      name: 'Abhishek Singh',
      role: 'Food & Beverages',
      phone: '+91 77200 70206',
      instagram: 'abhishekxd_07',
      linkedin: 'abhishek-singh-b54ba5295',
      imageUrl: 'assets/images/team/abhishek-min-B4rX4CHh.jpg',
    ),
    // Proshows
    TeamMember(
      name: 'Omshiva Kotkar',
      role: 'Proshows',
      phone: '+91 98207 87285',
      instagram: 'omshiva159',
      linkedin: 'omshiva-kotkar-87507b272',
      imageUrl: 'assets/images/team/omshiva-min-DnL29ZFV.jpg',
    ),
    TeamMember(
      name: 'Dishika Nawal',
      role: 'Proshows',
      phone: '+91 74897 44006',
      instagram: 'dishi_nawal',
      linkedin: 'dishika-nawal-1a1772305',
      imageUrl: 'assets/images/team/dishika-min-QNy--Ftz.jpg',
    ),
    TeamMember(
      name: 'Rahul Singh',
      role: 'Proshows',
      phone: '+91 79778 55692',
      instagram: 'rahull_0412',
      linkedin: 'rahul-singh-0589ab213',
      imageUrl: 'assets/images/team/Rahul-min-DkaWLc1g.jpg',
    ),
    // Hospitality
    TeamMember(
      name: 'Aditya Chauhan',
      role: 'Hospitality & PR',
      phone: '+91 77422 60468',
      instagram: 'adityarjchauhan02',
      linkedin: 'adityarajjichauhan',
      imageUrl: 'assets/images/team/chauhan-D5SnQJV2.jpg',
    ),
    TeamMember(
      name: 'Nikhil Upadhyay',
      role: 'Hospitality & PR',
      phone: '+91 73552 30725',
      instagram: 'thenikhilupadhyay',
      linkedin: 'nikhil-upadhyay-6a0ba4202',
      imageUrl: 'assets/images/team/nikhil-min-DBU-861a.jpg',
    ),
    // Informals
    TeamMember(
      name: 'Uday Doiphode',
      role: 'Informals & Workshops',
      phone: '+91 93246 07568',
      instagram: 'yayitsuday',
      linkedin: 'uday-doiphode',
      imageUrl: 'assets/images/team/Uday-min-5KjgHfJY.jpg',
    ),
    TeamMember(
      name: 'Rudra Pratap Singh',
      role: 'Informals & Workshops',
      phone: '+91 78791 76194',
      instagram: 'rudra_gurjar2005',
      imageUrl: 'assets/images/team/rudra-min-5j74qV2e.jpg',
    ),
    // Marketing
    TeamMember(
      name: 'Priyanshu Sengar',
      role: 'Marketing',
      phone: '+91 96960 15961',
      instagram: 'priyanshusengar11',
      linkedin: 'priyanshu-sengar-956620284',
      imageUrl: 'assets/images/team/priyanshu-min-C2Id5Oef.jpg',
    ),
    TeamMember(
      name: 'Harshit Sahu',
      role: 'Marketing',
      phone: '+91 94077 07594',
      instagram: 'harshisssssssss',
      linkedin: 'harshitsahu05',
      imageUrl: 'assets/images/team/harshit-min-CmD1XbOi.jpg',
    ),
    TeamMember(
      name: 'Anika Sahoo',
      role: 'Marketing',
      phone: '+91 93728 48223',
      instagram: 'anikaasahoo',
      linkedin: 'anika-sahoo-620000295',
      imageUrl: 'assets/images/team/anika-min-HwnoAJF7.jpg',
    ),
    // Media & Publicity
    TeamMember(
      name: 'Swati Pandey',
      role: 'Media & Publicity',
      phone: '+91 87920 47642',
      instagram: 'the.arcturuss',
      linkedin: 'swati-pandey-10574035a',
      imageUrl: 'assets/images/team/swati-min-CdyG4G94.jpg',
    ),
    TeamMember(
      name: 'Falguni Kashyap',
      role: 'Media & Publicity',
      phone: '+91 99386 02444',
      instagram: 'falguni_.k',
      linkedin: 'falguni-kashyap-a1a8aa297',
      imageUrl: 'assets/images/team/falguni-min-riDlkK87.jpg',
    ),
    // Operations
    TeamMember(
      name: 'Nitin Choudhary',
      role: 'Operations & Logistics',
      phone: '+91 92564 66521',
      instagram: 'nitin_choudhry.1',
      linkedin: 'nitin-choudhary-00344b310',
      imageUrl: 'assets/images/team/nitin-min-DeUHB1gj.jpg',
    ),
    TeamMember(
      name: 'Aditya Agrawal',
      role: 'Operations & Logistics',
      phone: '+91 79858 73748',
      instagram: 'adi.tya120905',
      linkedin: 'aditya-agrawal-528316280',
      imageUrl: 'assets/images/team/agrawal-min-C_BgG3LS.jpg',
    ),
    // Pronites
    TeamMember(
      name: 'Yog Sonawane',
      role: 'Pronites',
      phone: '+91 79770 58957',
      instagram: 'yog.sonawane',
      linkedin: 'yog-sonawane-2b5159310',
      imageUrl: 'assets/images/team/yog-min-B01uNqLH.jpg',
    ),
    TeamMember(
      name: 'Ranbir Sinha',
      role: 'Pronites',
      phone: '+91 91376 22913',
      instagram: 'ranbirsinhaaa',
      imageUrl: 'assets/images/team/ranbir-min-DIDUX5b0.jpg',
    ),
  ];
}
