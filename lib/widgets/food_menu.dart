import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/food_item.dart';

class FoodMenu extends StatelessWidget {
  final List<FoodItem> items;

  const FoodMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Toop Food Picks this week',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Column(
          children:
              items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _FoodMenuCard(item: item),
                    ),
                  )
                  .toList(),
        ),
      ],
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
      stars.add(const Icon(Icons.star, size: 14, color: Colors.amber));
    }
    if (hasHalf) {
      stars.add(const Icon(Icons.star_half, size: 14, color: Colors.amber));
    }
    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, size: 14, color: Colors.amber));
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    final quote = item.quotes.isNotEmpty ? item.quotes.first : null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stack) => Container(
                    width: 50,
                    height: 50,
                    color: const Color(0xFFFFF1C2),
                    child: const Icon(
                      Icons.fastfood,
                      color: Color(0xFFDA291C),
                      size: 24,
                    ),
                  ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name + stars + numeric rating
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    ..._buildStars(),
                    const SizedBox(width: 4),
                    Text(
                      item.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280),
                  ),
                ),
                if (quote != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    quote,
                    style: const TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                InkWell(
                  onTap: _openRestaurant,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.link,
                        size: 14,
                        color: Color(0xFFB91C1C),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.restaurantName,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFFB91C1C),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            item.price,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFFB91C1C),
            ),
          ),
        ],
      ),
    );
  }
}
