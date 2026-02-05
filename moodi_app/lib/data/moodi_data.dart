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
      venue: 'Main Stage, SAC',
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
      venue: 'Main Stage, SAC',
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
      venue: 'Main Stage, SAC',
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
      venue: 'Main Stage, SAC',
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
        {'time': '10:00 AM', 'title': 'Fest Inauguration', 'venue': 'Convocation Hall'},
        {'time': '11:00 AM', 'title': 'Music Production Workshop', 'venue': 'SOM Hall'},
        {'time': '2:00 PM', 'title': 'Livewire Round 1', 'venue': 'Open Air Theatre'},
        {'time': '3:00 PM', 'title': 'IMF - World Music', 'venue': 'OAT'},
        {'time': '5:00 PM', 'title': 'Cultural Carnival Begins', 'venue': 'Central Lawn'},
        {'time': '9:00 PM', 'title': 'PRONITE - Sonu Nigam', 'venue': 'Main Stage'},
      ],
    },
    {
      'day': 'Day 2',
      'date': 'December 16',
      'dayLabel': 'TUE',
      'events': [
        {'time': '10:00 AM', 'title': 'Art Competitions', 'venue': 'Design Centre'},
        {'time': '11:00 AM', 'title': 'Street Art Workshop', 'venue': 'Design Centre'},
        {'time': '2:00 PM', 'title': 'Livewire Round 2', 'venue': 'OAT'},
        {'time': '5:00 PM', 'title': 'Jazz & Blues Evening', 'venue': 'FC Kohli'},
        {'time': '6:00 PM', 'title': 'Improv Night', 'venue': 'LT-101'},
        {'time': '8:30 PM', 'title': 'PRONITE - Dhruv Visvanath', 'venue': 'Main Stage'},
        {'time': '10:00 PM', 'title': 'EDM Night', 'venue': 'Ground Stage'},
      ],
    },
    {
      'day': 'Day 3',
      'date': 'December 17',
      'dayLabel': 'WED',
      'events': [
        {'time': '10:00 AM', 'title': 'Dance Competitions', 'venue': 'SAC'},
        {'time': '2:00 PM', 'title': 'World Dance Championship', 'venue': 'Ground Stage'},
        {'time': '2:00 PM', 'title': 'Comedy Workshop', 'venue': 'LT-003'},
        {'time': '4:00 PM', 'title': 'Livewire Finals', 'venue': 'OAT'},
        {'time': '6:00 PM', 'title': 'Classical Jugalbandi', 'venue': 'Convo Hall'},
        {'time': '9:00 PM', 'title': 'PRONITE - Shankar Mahadevan', 'venue': 'Main Stage'},
      ],
    },
    {
      'day': 'Day 4',
      'date': 'December 18',
      'dayLabel': 'THU',
      'events': [
        {'time': '10:00 AM', 'title': 'LitFest Panels', 'venue': 'FC Kohli'},
        {'time': '12:00 PM', 'title': 'Photography Walk', 'venue': 'Campus'},
        {'time': '3:00 PM', 'title': 'Fashion Show - SGTL', 'venue': 'SAC'},
        {'time': '5:00 PM', 'title': 'Award Ceremonies', 'venue': 'Convo Hall'},
        {'time': '8:00 PM', 'title': 'HUMOR FEST - Grand Finale', 'venue': 'Main Stage'},
        {'time': '10:00 PM', 'title': 'Closing Ceremony', 'venue': 'Main Stage'},
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
}
