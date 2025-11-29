import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/food_item.dart';

class FoodMenu extends StatelessWidget {
  final List<FoodItem> items;

  const FoodMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF0),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFE4A3)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header row – small & subtle
          Row(
            children: [
              const Icon(Icons.fastfood, size: 16, color: Color(0xFFB91C1C)),
              const SizedBox(width: 6),
              const Text(
                'Food nearby',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              const Spacer(),
              const Text(
                'Google Map API (Food Places)',
                style: TextStyle(
                  fontSize: 10,
                  color: Color.fromARGB(255, 6, 76, 215),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // compact vertical list in its own scroll box
          SizedBox(
            height: 150, // controls how tall the food section feels
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                return _FoodMenuCard(item: items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodMenuCard extends StatelessWidget {
  final FoodItem item;

  const _FoodMenuCard({required this.item});

  Future<void> _openRestaurant() async {
    final uri = Uri.parse(item.restaurantUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  List<Widget> _buildStars() {
    final stars = <Widget>[];
    final full = item.rating.floor();
    final hasHalf = (item.rating - full) >= 0.5;

    for (var i = 0; i < full; i++) {
      stars.add(const Icon(Icons.star, size: 11, color: Colors.amber));
    }
    if (hasHalf) {
      stars.add(const Icon(Icons.star_half, size: 11, color: Colors.amber));
    }
    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, size: 11, color: Colors.amber));
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    final quote = item.quotes.isNotEmpty ? item.quotes.first : null;

    return InkWell(
      onTap: _openRestaurant,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        // full width inside the FoodMenu container
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            // small image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.imageUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stack) => Container(
                      width: 40,
                      height: 40,
                      color: const Color(0xFFFFF1C2),
                      child: const Icon(
                        Icons.fastfood,
                        color: Color(0xFFDA291C),
                        size: 20,
                      ),
                    ),
              ),
            ),
            const SizedBox(width: 8),

            // text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name + price
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.price,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFB91C1C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),

                  // stars + rating
                  Row(
                    children: [
                      ..._buildStars(),
                      const SizedBox(width: 3),
                      Text(
                        item.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),

                  // one-line quote or restaurant name
                  const SizedBox(height: 2),
                  Text(
                    quote ?? item.restaurantName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF6B7280),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
