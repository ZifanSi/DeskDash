import 'package:flutter/material.dart';
import '../models/study_place.dart';
import 'place_details_screen.dart';

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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildSearchBar(),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildFilterChips(),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child:
                    visibleList.isEmpty
                        ? _buildEmptyState()
                        : ListView.separated(
                          key: ValueKey(_currentTab.toString() + _searchQuery),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: visibleList.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final place = visibleList[index];
                            final isFav = widget.favorites.any(
                              (p) => p.id == place.id,
                            );
                            final isVisited = widget.visited.any(
                              (p) => p.id == place.id,
                            );

                            return _StudyPlaceCard(
                              place: place,
                              isFavorite: isFav,
                              isVisited: isVisited,
                              onFavoriteTap: () {
                                widget.onToggleFavorite(place);
                                setState(() {});
                              },
                              onTap: () async {
                                await Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (_, a1, __) => FadeTransition(
                                          opacity: a1,
                                          child: PlaceDetailsScreen(
                                            place: place,
                                            isFavorite: isFav,
                                            isVisited: isVisited,
                                            onToggleFavorite:
                                                widget.onToggleFavorite,
                                            onToggleVisited:
                                                widget.onToggleVisited,
                                          ),
                                        ),
                                    transitionDuration: const Duration(
                                      milliseconds: 220,
                                    ),
                                  ),
                                );
                                setState(() {}); // refresh badges
                              },
                            );
                          },
                        ),
              ),
            ),
          ],
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFC72C), // yellow
                  Color(0xFFDA291C), // red
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
      ),
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
        children:
            _availableFilters.map((label) {
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

  @override
  Widget build(BuildContext context) {
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
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFC72C), // yellow
                        Color(0xFFDA291C), // red
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.chair_alt, color: Colors.white, size: 26),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        children:
                            place.tags.take(3).map((tag) {
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
