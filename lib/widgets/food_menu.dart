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
          'Food nearby (mock menu)',
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
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // ignore failure in this mock app
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280),
                  ),
                ),
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
