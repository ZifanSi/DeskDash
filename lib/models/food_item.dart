class FoodItem {
  final String id;
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final String restaurantName;
  final String restaurantUrl;

  // NEW
  final double rating; // e.g. 4.6
  final List<String> quotes; // mock short reviews

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.restaurantName,
    required this.restaurantUrl,
    required this.rating,
    required this.quotes,
  });
}
