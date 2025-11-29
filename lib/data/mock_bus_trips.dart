import '../models/bus_trip.dart';

const mockBusTrips = <BusTrip>[
  BusTrip(
    id: 'bus-51-1',
    route: '51 University',
    direction: 'To Downtown',
    stop: 'MUSC Loop (Main St W)',
    timeLabel: 'in 5 min',
    clockTime: '13:05',
    provider: 'HSR',
  ),
  BusTrip(
    id: 'bus-5-1',
    route: '5 Delaware',
    direction: 'To Stoney Creek',
    stop: 'Main St W @ Emerson',
    timeLabel: 'in 18 min',
    clockTime: '13:18',
    provider: 'HSR',
  ),
  BusTrip(
    id: 'bus-10-1',
    route: '10 B-Line',
    direction: 'To Downtown',
    stop: 'Main St W @ Cootes',
    timeLabel: 'in 27 min',
    clockTime: '13:27',
    provider: 'HSR',
  ),
  BusTrip(
    id: 'bus-52-1',
    route: '52 Dundas',
    direction: 'To Dundas',
    stop: 'Main St W @ Osler',
    timeLabel: 'in 42 min',
    clockTime: '13:42',
    provider: 'HSR',
  ),
];
