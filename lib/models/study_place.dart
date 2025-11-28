class StudyPlace {
  final String id;
  final String name;
  final String building;
  final String description;
  final List<String> tags; // e.g. ["Quiet", "Near food"]
  final double rating; // 0–5
  final String noise; // e.g. "Usually quiet"
  final String crowdedness; // e.g. "Busy at lunch"
  final bool hasOutlets;
  final bool nearFood;
  final List<String> reviews;

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
  });
}
