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
                    const SizedBox(height: 14),
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
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white.withOpacity(0.15),
              ),
              child: const Center(
                child: Icon(Icons.chair_alt, color: Colors.white, size: 32),
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
                      const SizedBox(width: 10),
                      Text(
                        '• ${place.noise}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFE5E7EB),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '• ${place.crowdedness}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFE5E7EB),
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
