import 'nearby_food_spot.dart';

class StudyPlace {
  final String id;
  final String name;
  final String building;
  final String description;
  final List<String> tags;
  final double rating;
  final String noise;
  final String crowdedness;
  final bool hasOutlets;
  final bool nearFood;
  final List<String> reviews;

  // NEW: use URLs instead of asset paths
  final String imageUrl; // banner image URL
  final List<NearbyFoodSpot> nearbyFood; // food with logo URLs

  const StudyPlace({
    required this.id,
    required this.name,
    required this.building,
    required this.description,
    required this.tags,
    required this.rating,
    required this.noise,
    required this.crowdedness,
    required this.hasOutlets,
    required this.nearFood,
    this.reviews = const [],
    required this.imageUrl,
    this.nearbyFood = const [],
  });
}
