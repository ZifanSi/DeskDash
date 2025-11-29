// lib/screens/place_details_screen.dart
import 'package:flutter/material.dart';
import '../models/study_place.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final StudyPlace place;
  final bool isFavorite;
  final bool isVisited;
  final void Function(StudyPlace) onToggleFavorite;
  final void Function(StudyPlace) onToggleVisited;

  const PlaceDetailsScreen({
    super.key,
    required this.place,
    required this.isFavorite,
    required this.isVisited,
    required this.onToggleFavorite,
    required this.onToggleVisited,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroCard(context),
                    const SizedBox(height: 16),
                    Text(
                      place.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children:
                          place.tags
                              .map(
                                (t) => Chip(
                                  label: Text(t),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 20),
                    _buildCapacitySection(context),
                    const SizedBox(height: 20),
                    _buildActions(context),
                    const SizedBox(height: 24),
                    _buildReviewsSection(context),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- TOP BAR ----------------

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'Study place',
            style: TextStyle(fontSize: 14, color: Color(0xFF111827)),
          ),
        ],
      ),
    );
  }

  // ---------------- HERO CARD ----------------

  Widget _buildHeroCard(BuildContext context) {
    return Hero(
      tag: 'place-${place.id}',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFC72C), // yellow
              Color(0xFFDA291C), // red
            ],
          ),
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                place.imageUrl,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      width: 72,
                      height: 72,
                      color: Colors.white.withOpacity(0.15),
                      child: const Center(
                        child: Icon(
                          Icons.chair_alt,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    place.building,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber.shade400, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        place.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- CAPACITY / GRAPH SECTION ----------------

  Widget _buildCapacitySection(BuildContext context) {
    // avoid divide-by-zero
    final seatsTotal = place.seatsTotal <= 0 ? 1 : place.seatsTotal;
    final foodTotal = place.foodOptionsTotal <= 0 ? 1 : place.foodOptionsTotal;

    final seatsFreeFraction = (place.seatsAvailable / seatsTotal).clamp(
      0.0,
      1.0,
    );
    final foodOpenFraction = (place.foodOptionsOpen / foodTotal).clamp(
      0.0,
      1.0,
    );
    final quietFraction = (1.0 - place.noiseScore).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF0),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFE4A3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Live comfort snapshot (mock)',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 10),

          // Seats row
          _CapacityBarRow(
            label: 'Seats free',
            valueLabel: '${place.seatsAvailable} / ${place.seatsTotal}',
            fraction: seatsFreeFraction,
            barColor: const Color(0xFF22C55E), // green
          ),
          const SizedBox(height: 8),

          // Food row
          _CapacityBarRow(
            label: 'Food spots open',
            valueLabel: '${place.foodOptionsOpen} / ${place.foodOptionsTotal}',
            fraction: foodOpenFraction,
            barColor: const Color(0xFFFFC72C), // yellow
          ),
          const SizedBox(height: 8),

          // Quietness row
          _CapacityBarRow(
            label: 'Quietness',
            valueLabel: '${((quietFraction) * 100).round()}% quiet',
            fraction: quietFraction,
            barColor: const Color(0xFF3B82F6), // blue
          ),

          const SizedBox(height: 6),
          const Text(
            'Numbers are mock data in this prototype, but show how capacity-based info could look in a real app.',
            style: TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  // ---------------- ACTION BUTTONS ----------------

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () {
              onToggleFavorite(place);
              Navigator.of(context).maybePop();
            },
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            label: Text(
              isFavorite ? 'Remove from favorites' : 'Save to favorites',
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              onToggleVisited(place);
              Navigator.of(context).maybePop();
            },
            icon: Icon(
              isVisited ? Icons.check_circle : Icons.check_circle_outline,
            ),
            label: Text(isVisited ? 'Mark unvisited' : 'Mark visited'),
          ),
        ),
      ],
    );
  }

  // ---------------- REVIEWS ----------------

  Widget _buildReviewsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        if (place.reviews.isEmpty)
          Text(
            'No reviews yet. In a real app, students would leave comments here.',
            style: Theme.of(context).textTheme.bodySmall,
          )
        else
          Column(
            children:
                place.reviews
                    .map(
                      (r) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xFFFFF3D6),
                          child: Icon(
                            Icons.person_outline,
                            size: 18,
                            color: Color(0xFF111827),
                          ),
                        ),
                        title: Text(
                          r,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
          ),
      ],
    );
  }
}

// ---------------- SMALL CAPACITY BAR WIDGET ----------------

class _CapacityBarRow extends StatelessWidget {
  final String label;
  final String valueLabel;
  final double fraction;
  final Color barColor;

  const _CapacityBarRow({
    required this.label,
    required this.valueLabel,
    required this.fraction,
    required this.barColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF111827),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              valueLabel,
              style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: 6,
            backgroundColor: const Color(0xFFF3F4F6),
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
          ),
        ),
      ],
    );
  }
}
