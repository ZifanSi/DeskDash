import 'package:flutter/material.dart';
import 'models/study_place.dart';
import 'data/mock_places.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const DeskDashApp());
}

class DeskDashApp extends StatefulWidget {
  const DeskDashApp({super.key});

  @override
  State<DeskDashApp> createState() => _DeskDashAppState();
}

class _DeskDashAppState extends State<DeskDashApp> {
  final List<StudyPlace> _favorites = [];
  final List<StudyPlace> _visited = [];

  void _toggleFavorite(StudyPlace place) {
    setState(() {
      if (_favorites.any((p) => p.id == place.id)) {
        _favorites.removeWhere((p) => p.id == place.id);
      } else {
        _favorites.add(place);
      }
    });
  }

  void _toggleVisited(StudyPlace place) {
    setState(() {
      if (_visited.any((p) => p.id == place.id)) {
        _visited.removeWhere((p) => p.id == place.id);
      } else {
        _visited.add(place);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // McDonald's brand-ish colors
    const mcdRed = Color(0xFFDA291C);
    const mcdYellow = Color(0xFFFFC72C);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: mcdRed,
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'DeskDash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,

        // light, warm background
        scaffoldBackgroundColor: const Color(0xFFFFF7E6),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
        ),

        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827), // almost-black
          ),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF1F2933)),
          bodySmall: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
        ),

        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: mcdRed,
          indicatorColor: Colors.white.withOpacity(0.18),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          iconTheme: WidgetStateProperty.all(
            const IconThemeData(color: Colors.white),
          ),
        ),

        cardTheme: CardTheme(
          color: Colors.white,
          shadowColor: Colors.black.withOpacity(0.12),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFFF3D6),
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(999),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
      ),
      home: HomeScreen(
        allPlaces: mockPlaces,
        favorites: _favorites,
        visited: _visited,
        onToggleFavorite: _toggleFavorite,
        onToggleVisited: _toggleVisited,
      ),
    );
  }
}
