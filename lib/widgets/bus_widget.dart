import 'package:flutter/material.dart';
import '../models/bus_trip.dart';

class BusWidget extends StatelessWidget {
  final List<BusTrip> trips;

  const BusWidget({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFDBEAFE)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: const [
              Icon(Icons.directions_bus, size: 16, color: Color(0xFF1D4ED8)),
              SizedBox(width: 6),
              Text(
                'Buses in next hour',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              Spacer(),
              Text(
                'Google Map API (Transit)',
                style: TextStyle(fontSize: 10, color: Color(0xFF1D4ED8)),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Compact vertical list
          SizedBox(
            height: 140,
            child: ListView.separated(
              itemCount: trips.length,
              separatorBuilder: (_, __) => const SizedBox(height: 6),
              itemBuilder: (context, index) {
                return _BusTripCard(trip: trips[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BusTripCard extends StatelessWidget {
  final BusTrip trip;

  const _BusTripCard({required this.trip});

  Color _routeColor() {
    if (trip.provider == 'GO') return const Color(0xFF047857); // green
    // simple mapping by route number
    if (trip.route.startsWith('51')) return const Color(0xFF1D4ED8); // blue
    if (trip.route.startsWith('5')) return const Color(0xFFB91C1C); // red
    if (trip.route.startsWith('10')) return const Color(0xFF6366F1); // indigo
    return const Color(0xFF0F766E); // teal fallback
  }

  @override
  Widget build(BuildContext context) {
    final color = _routeColor();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          // route pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.directions_bus, size: 12, color: color),
                const SizedBox(width: 4),
                Text(
                  trip.route,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // stop + direction
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.stop,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  trip.direction,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // time block
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                trip.timeLabel,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                trip.clockTime,
                style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 2),
              Text(
                trip.provider,
                style: const TextStyle(fontSize: 9, color: Color(0xFF6B7280)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
