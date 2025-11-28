import 'package:flutter/material.dart';
import '../models/study_place.dart';

class PlaceDetailsScreen extends StatefulWidget {
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
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  late List<String> _reviews;
  final TextEditingController _reviewController = TextEditingController();
  int _selectedRating = 4;

  @override
  void initState() {
    super.initState();
    _reviews = List<String>.from(widget.place.reviews);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    final text = _reviewController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _reviews.insert(0, '$_selectedRating★  ·  $text');
      _reviewController.clear();
      _selectedRating = 4;
    });

    // For this assignment prototype, we keep reviews in local state.
    // In a real app, you'd also update the model / backend here.
  }

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
                    _buildBannerImage(),
                    const SizedBox(height: 12),
                    _buildHeroCard(context),
                    const SizedBox(height: 16),
                    Text(
                      widget.place.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children:
                          widget.place.tags
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

  // ---------- top bar & hero ----------

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

  Widget _buildBannerImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          widget.place.imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE5E7EB),
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return Hero(
      tag: 'place-${widget.place.id}',
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
                    widget.place.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.place.building,
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
                        widget.place.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '• ${widget.place.noise}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFE5E7EB),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '• ${widget.place.crowdedness}',
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

  // ---------- actions (favorite / visited) ----------

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () {
              widget.onToggleFavorite(widget.place);
              Navigator.of(context).maybePop();
            },
            icon: Icon(
              widget.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            label: Text(
              widget.isFavorite ? 'Remove from favorites' : 'Save to favorites',
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              widget.onToggleVisited(widget.place);
              Navigator.of(context).maybePop();
            },
            icon: Icon(
              widget.isVisited
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
            ),
            label: Text(widget.isVisited ? 'Mark unvisited' : 'Mark visited'),
          ),
        ),
      ],
    );
  }

  // ---------- reviews (view + write) ----------

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

        // Write review block
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rate & review this place',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  final selected = starIndex <= _selectedRating;
                  return IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    icon: Icon(
                      selected ? Icons.star : Icons.star_border,
                      size: 22,
                      color: Colors.amber.shade400,
                    ),
                    onPressed: () {
                      setState(() => _selectedRating = starIndex);
                    },
                  );
                }),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _reviewController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Share a quick tip or comment...',
                  isDense: true,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: _submitReview,
                  child: const Text('Post review'),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        if (_reviews.isEmpty)
          Text(
            'No reviews yet. Be the first to share how this spot feels for studying.',
            style: Theme.of(context).textTheme.bodySmall,
          )
        else
          Column(
            children:
                _reviews
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
