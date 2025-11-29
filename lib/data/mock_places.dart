// lib/data/mock_places.dart
import '../models/study_place.dart';

const mockPlaces = <StudyPlace>[
  StudyPlace(
    id: 'mills-4f-quiet',
    name: 'Mills Library – 4th Floor Quiet Zone',
    building: 'Mills Library',
    description:
        'Carrels and window desks for silent study. Best for reading and solo work.',
    tags: ['Quiet', 'Outlets', 'Indoor'],
    rating: 4.7,
    imageUrl:
        'https://images.pexels.com/photos/2041540/pexels-photo-2041540.jpeg',
    // capacity
    seatsTotal: 180,
    seatsAvailable: 40, // 40 seats free
    // food around Mills (mock)
    foodOptionsTotal: 2,
    foodOptionsOpen: 1, // e.g. Starbucks open, cafe closed
    // noise (0–1)
    noiseScore: 0.2, // very quiet
    reviews: [
      'Usually silent in the mornings.',
      'Great for deep work, but plugs fill up fast.',
    ],
    indoor: true,
    nearFood: true,
  ),
  StudyPlace(
    id: 'thode-2f-group',
    name: 'Thode Library – 2nd Floor Group Tables',
    building: 'Thode Library',
    description:
        'Open group tables near whiteboards, good for project meetings.',
    tags: ['Group-friendly', 'Outlets', 'Indoor'],
    rating: 4.1,
    imageUrl:
        'https://images.pexels.com/photos/1181675/pexels-photo-1181675.jpeg',
    seatsTotal: 120,
    seatsAvailable: 15, // quite busy
    foodOptionsTotal: 3,
    foodOptionsOpen: 2,
    noiseScore: 0.7, // fairly loud
    reviews: [
      'Great for group work, but expect noise.',
      'Close to cafe, easy to grab coffee.',
    ],
    indoor: true,
    nearFood: true,
  ),
  StudyPlace(
    id: 'muscoutdoor',
    name: 'MUSC Outdoor Patio Tables',
    building: 'MUSC',
    description:
        'Outdoor tables near La Piazza. Good when the weather is nice.',
    tags: ['Outdoor', 'Near food'],
    rating: 4.0,
    imageUrl:
        'https://images.pexels.com/photos/380769/pexels-photo-380769.jpeg',
    seatsTotal: 60,
    seatsAvailable: 45, // a lot of space
    foodOptionsTotal: 4,
    foodOptionsOpen: 3,
    noiseScore: 0.5,
    reviews: [
      'Nice in spring/fall, a bit windy.',
      'Perfect when you want food + sun.',
    ],
    indoor: false,
    nearFood: true,
  ),
];
