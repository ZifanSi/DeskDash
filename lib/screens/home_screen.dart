import 'package:flutter/material.dart';
import '../models/study_place.dart';
import 'place_details_screen.dart';
import '../widgets/food_menu.dart';
import '../data/mock_food_menu.dart';

class HomeScreen extends StatefulWidget {
  final List<StudyPlace> allPlaces;
  final List<StudyPlace> favorites;
  final List<StudyPlace> visited;
  final void Function(StudyPlace) onToggleFavorite;
  final void Function(StudyPlace) onToggleVisited;

  const HomeScreen({
    super.key,
    required this.allPlaces,
    required this.favorites,
    required this.visited,
    required this.onToggleFavorite,
    required this.onToggleVisited,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0; // 0 = Discover, 1 = Favorites, 2 = Visited
  String _searchQuery = '';
  final Set<String> _activeFilters = {};

  final List<String> _availableFilters = const [
    'Quiet',
    'Group-friendly',
    'Near food',
    'Outlets',
    'Indoor',
    'Outdoor',
  ];

  List<StudyPlace> _filterPlaces(List<StudyPlace> source) {
    final query = _searchQuery.toLowerCase();

    return source.where((place) {
      final matchesQuery =
          place.name.toLowerCase().contains(query) ||
          place.building.toLowerCase().contains(query);

      final matchesFilters =
          _activeFilters.isEmpty ||
          _activeFilters.every((f) => place.tags.contains(f));

      return matchesQuery && matchesFilters;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final allFiltered = _filterPlaces(widget.allPlaces);
    final favoritesFiltered = _filterPlaces(widget.favorites);
    final visitedFiltered = _filterPlaces(widget.visited);

    List<StudyPlace> visibleList;
    switch (_currentTab) {
      case 1:
        visibleList = favoritesFiltered;
        break;
      case 2:
        visibleList = visitedFiltered;
        break;
      default:
        visibleList = allFiltered;
    }

    const headerCount = 4; // header, search, chips, food section
    final hasPlaces = visibleList.isNotEmpty;
    final totalCount = headerCount + (hasPlaces ? visibleList.length : 1);

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: totalCount,
          itemBuilder: (context, index) {
            // 0: header
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                child: _buildHeader(context),
              );
            }

            // 1: search bar
            if (index == 1) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                child: _buildSearchBar(),
              );
            }

            // 2: filter chips
            if (index == 2) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                child: _buildFilterChips(),
              );
            }

            // 3: fancy food section
            if (index == 3) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
                child: FoodMenu(items: mockFoodMenu),
              );
            }

            // after headerCount: either empty state or study place cards
            if (!hasPlaces) {
              // just one empty-state block
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: _buildEmptyState(),
              );
            }

            final placeIndex = index - headerCount;
            final place = visibleList[placeIndex];
            final isFav =
                widget.favorites.any((p) => p.id == place.id);
            final isVisited =
                widget.visited.any((p) => p.id == place.id);

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
              child: _StudyPlaceCard(
                place: place,
                isFavorite: isFav,
                isVisited: isVisited,
                onFavoriteTap: () {
                  widget.onToggleFavorite(place);
                  // no setState here – parent list rebuilds on next frame anyway
                  (context as Element).markNeedsBuild();
                },
                onTap: () async {
                  await Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, a1, __) => FadeTransition(
                        opacity: a1,
                        child: PlaceDetailsScreen(
                          place: place,
                          isFavorite: isFav,
                          isVisited: isVisited,
                          onToggleFavorite: widget.onToggleFavorite,
                          onToggleVisited: widget.onToggleVisited,
                        ),
                      ),
                      transitionDuration:
                          const Duration(milliseconds: 220),
                    ),
                  );
                  (context as Element).markNeedsBuild();
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentTab,
        onDestinationSelected: (i) {
          setState(() => _currentTab = i);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Discover',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: 'Visited',
          ),
        ],
      ),
    );
  }

  // ---------- helpers for header / search / chips / empty ----------

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFC72C), // McD yellow
                Color(0xFFDA291C), // McD red
              ],
            ),
          ),
          child: const Center(
            child: Icon(Icons.chair_alt, color: Colors.white, size: 22),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('DeskDash', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 2),
              Text(
                'Find your next go-to study spot on campus.',
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) => setState(() => _searchQuery = value),
      style: const TextStyle(color: Color(0xFF111827)),
      decoration: const InputDecoration(
        hintText: 'Search by name or building',
        prefixIcon: Icon(Icons.search, color: Color(0xFF9CA3AF)),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _availableFilters.map((label) {
          final selected = _activeFilters.contains(label);
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(label),
              selected: selected,
              onSelected: (value) {
                setState(() {
                  if (value) {
                    _activeFilters.add(label);
                  } else {
                    _activeFilters.remove(label);
                  }
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.chair_outlined,
              size: 60,
              color: Color(0xFF9CA3AF),
            ),
            const SizedBox(height: 12),
            Text(
              'No study places match your search yet.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'Try clearing a filter or searching by a different building or vibe.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Study place card with mini charts on main page ----------

class _StudyPlaceCard extends StatelessWidget {
  final StudyPlace place;
  final bool isFavorite;
  final bool isVisited;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  const _StudyPlaceCard({
    required this.place,
    required this.isFavorite,
    required this.isVisited,
    required this.onFavoriteTap,
    required this.onTap,
  });

  double _scoreFromLabel(String label, {bool invert = false}) {
    final l = label.toLowerCase();
    double v;

    if (l.contains('silent') || l.contains('very quiet')) {
      v = 0.1;
    } else if (l.contains('quiet')) {
      v = 0.3;
    } else if (l.contains('moderate') || l.contains('medium')) {
      v = 0.6;
    } else if (l.contains('busy') || l.contains('loud') || l.contains('noisy')) {
      v = 0.9;
    } else {
      v = 0.5;
    }

    if (invert) v = 1.0 - v;
    if (v < 0) v = 0;
    if (v > 1) v = 1;
    return v;
  }

  Widget _miniBar(double value, Color color) {
    return SizedBox(
      width: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: LinearProgressIndicator(
          value: value,
          minHeight: 4,
          backgroundColor: const Color(0xFFE5E7EB),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // scores for mini charts
    final noiseScore = _scoreFromLabel(place.noise, invert: true);
    final crowdedScore = _scoreFromLabel(place.crowdedness, invert: true);
    double foodScore;
    if (place.nearFood) {
      foodScore = 0.85;
    } else if ((place.nearbyFood?.length ?? 0) > 0) {
      foodScore = 0.65;
    } else {
      foodScore = 0.3;
    }

    return Hero(
      tag: 'place-${place.id}',
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 56,
                  height: 56,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      place.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFFFF3D6),
                          child: const Center(
                            child: Icon(
                              Icons.chair_alt,
                              color: Color(0xFFDA291C),
                              size: 24,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title + rating row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              place.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.star,
                            size: 18,
                            color: Colors.amber.shade400,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            place.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        place.building,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 2,
                        children: place.tags.take(3).map((tag) {
                          return Text(
                            '#$tag',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF9CA3AF),
                            ),
                          );
                        }).toList(),
                      ),
                      if (isVisited)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.check_circle,
                                size: 14,
                                color: Color(0xFF16A34A),
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Visited',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF16A34A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 8),

                      // mini vibe charts row
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Noise',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              const SizedBox(height: 2),
                              _miniBar(
                                noiseScore,
                                const Color(0xFF22C55E), // green
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Crowd',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              const SizedBox(height: 2),
                              _miniBar(
                                crowdedScore,
                                const Color(0xFFFFC72C), // yellow
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Food',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              const SizedBox(height: 2),
                              _miniBar(
                                foodScore,
                                const Color(0xFFDA291C), // red
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onFavoriteTap,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color:
                        isFavorite ? Colors.redAccent : const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
