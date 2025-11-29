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

  @override
  void initState() {
    super.initState();
    _reviews = List<String>.from(widget.place.reviews);
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
                    _buildHeroCard(context),
                    const SizedBox(height: 16),
                    Text(
                      widget.place.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                widget.place.imageUrl,
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
    final seatsTotal =
        widget.place.seatsTotal <= 0 ? 1 : widget.place.seatsTotal;
    final foodTotal =
        widget.place.foodOptionsTotal <= 0 ? 1 : widget.place.foodOptionsTotal;

    final seatsFreeFraction = (widget.place.seatsAvailable / seatsTotal).clamp(
      0.0,
      1.0,
    );
    final foodOpenFraction = (widget.place.foodOptionsOpen / foodTotal).clamp(
      0.0,
      1.0,
    );
    final quietFraction = (1.0 - widget.place.noiseScore).clamp(0.0, 1.0);

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

          _CapacityBarRow(
            label: 'Seats free',
            valueLabel:
                '${widget.place.seatsAvailable} / ${widget.place.seatsTotal}',
            fraction: seatsFreeFraction,
            barColor: const Color(0xFF22C55E), // green
          ),
          const SizedBox(height: 8),

          _CapacityBarRow(
            label: 'Food spots open',
            valueLabel:
                '${widget.place.foodOptionsOpen} / ${widget.place.foodOptionsTotal}',
            fraction: foodOpenFraction,
            barColor: const Color(0xFFFFC72C), // yellow
          ),
          const SizedBox(height: 8),

          _CapacityBarRow(
            label: 'Quietness',
            valueLabel: '${(quietFraction * 100).round()}% quiet',
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
    final isFavorite = widget.isFavorite;
    final isVisited = widget.isVisited;

    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () {
              widget.onToggleFavorite(widget.place);
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
              widget.onToggleVisited(widget.place);
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

  // ---------------- REVIEWS + WRITE REVIEW ----------------

  Widget _buildReviewsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Reviews',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () => _openAddReviewSheet(context),
              icon: const Icon(Icons.rate_review, size: 16),
              label: const Text(
                'Write a review',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_reviews.isEmpty)
          Text(
            'No reviews yet. In a real app, students would leave comments here.',
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

  void _openAddReviewSheet(BuildContext context) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Write a review',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'How was this study place?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(sheetContext).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      final text = controller.text.trim();
                      if (text.isEmpty) return;
                      setState(() {
                        _reviews.insert(0, text);
                      });
                      Navigator.of(sheetContext).pop();
                    },
                    child: const Text('Post'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
