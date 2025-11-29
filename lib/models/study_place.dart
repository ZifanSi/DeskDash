// lib/models/study_place.dart
class StudyPlace {
  final String id;
  final String name;
  final String building;
  final String description;
  final List<String> tags;
  final double rating;
  final String imageUrl;

  // NEW: capacity-based fields
  final int seatsTotal; // e.g. 320
  final int seatsAvailable; // e.g. 100 (free seats)

  // NEW: nearby food capacity
  final int foodOptionsTotal; // e.g. 4 food spots around here
  final int foodOptionsOpen; // e.g. 3 currently open

  // You can still keep any older fields you had (noise, nearFood, reviews, etc.)
  final double noiseScore; // 0.0 = very quiet, 1.0 = very loud (for bar)
  final List<String> reviews;
  final bool indoor;
  final bool nearFood;

  const StudyPlace({
    required this.id,
    required this.name,
    required this.building,
    required this.description,
    required this.tags,
    required this.rating,
    required this.imageUrl,
    required this.seatsTotal,
    required this.seatsAvailable,
    required this.foodOptionsTotal,
    required this.foodOptionsOpen,
    required this.noiseScore,
    required this.reviews,
    required this.indoor,
    required this.nearFood,
  });
}
