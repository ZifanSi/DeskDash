class NearbyFoodSpot {
  final String name;
  final String logoUrl; // e.g. 'https://.../tims_logo.png'
  final String distance; // e.g. '2 min walk'
  final String note; // e.g. 'Coffee & snacks'

  const NearbyFoodSpot({
    required this.name,
    required this.logoUrl,
    required this.distance,
    required this.note,
  });
}
