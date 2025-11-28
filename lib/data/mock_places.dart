import '../models/study_place.dart';

const List<StudyPlace> mockPlaces = [
  StudyPlace(
    id: 'mills-quiet-4f',
    name: 'Mills Library Quiet Zone',
    building: 'Mills Library 4th Floor',
    description:
        'Quiet individual study area with large desks, power outlets, and bright lighting.',
    tags: ['Quiet', 'Outlets', 'Indoor', 'Individual'],
    rating: 4.6,
    noise: 'Very quiet',
    crowdedness: 'Moderately busy during exams',
    hasOutlets: true,
    nearFood: false,
    reviews: [
      'Great for solo work, almost always quiet.',
      'Outlets at almost every seat. Lighting can be a bit harsh at night.',
    ],
  ),
  StudyPlace(
    id: 'thode-group',
    name: 'Thode Group Study Tables',
    building: 'Thode Library 2nd Floor',
    description:
        'Open group tables near whiteboards, good for collaboration and problem sets.',
    tags: ['Group-friendly', 'Whiteboards', 'Indoor', 'Moderate noise'],
    rating: 4.2,
    noise: 'Moderate, lots of talking',
    crowdedness: 'Busy most afternoons',
    hasOutlets: true,
    nearFood: true,
    reviews: [
      'Perfect for group work, but bring headphones if you need focus.',
    ],
  ),
  StudyPlace(
    id: 'student-center-cafe',
    name: 'Student Centre Cafe Seats',
    building: 'Student Centre',
    description:
        'Cafe-style seating with easy access to food and coffee. Good for light reading.',
    tags: ['Near food', 'Casual', 'Outdoor nearby', 'Lively'],
    rating: 3.8,
    noise: 'Loud, lots of background noise',
    crowdedness: 'Very busy at lunch',
    hasOutlets: false,
    nearFood: true,
    reviews: ['Nice vibe but can get loud. Good for low-focus tasks.'],
  ),
];
