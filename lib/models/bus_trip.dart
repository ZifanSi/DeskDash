class BusTrip {
  final String id;
  final String route; // e.g., "51 University"
  final String direction; // e.g., "To Downtown"
  final String stop; // e.g., "MUSC Loop (Main St W)"
  final String timeLabel; // e.g., "in 5 min"
  final String clockTime; // e.g., "13:05"
  final String provider; // e.g., "HSR" or "GO"

  const BusTrip({
    required this.id,
    required this.route,
    required this.direction,
    required this.stop,
    required this.timeLabel,
    required this.clockTime,
    required this.provider,
  });
}
