import '../models/study_place.dart';
import '../models/nearby_food_spot.dart';

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
    imageUrl:
        'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=1200&q=80',
    nearbyFood: [
      NearbyFoodSpot(
        name: 'Campus Café North',
        logoUrl:
            'https://images.unsplash.com/photo-1511920925118-0a4b9e6a4a70?auto=format&fit=crop&w=200&q=80',
        distance: '3 min walk',
        note: 'Sandwiches, coffee, light snacks.',
      ),
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
    imageUrl:
        'https://images.unsplash.com/photo-1523580846011-d3a5bc25702b?auto=format&fit=crop&w=1200&q=80',
    nearbyFood: [
      NearbyFoodSpot(
        name: 'Tim\'s @ Thode',
        logoUrl:
            'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=200&q=80',
        distance: '1 min walk',
        note: 'Coffee, donuts, classic student fuel.',
      ),
      NearbyFoodSpot(
        name: 'Sci Barista Cart',
        logoUrl:
            'https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&w=200&q=80',
        distance: '2 min walk',
        note: 'Specialty coffee, limited snacks.',
      ),
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
    imageUrl:
        'https://images.unsplash.com/photo-1521017432531-fbd92d768814?auto=format&fit=crop&w=1200&q=80',
    nearbyFood: [
      NearbyFoodSpot(
        name: 'Student Centre Food Court',
        logoUrl:
            'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=200&q=80',
        distance: 'On site',
        note: 'Multiple vendors, full meals & snacks.',
      ),
      NearbyFoodSpot(
        name: 'Express Coffee Cart',
        logoUrl:
            'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=200&q=80',
        distance: '1 min walk',
        note: 'Quick coffee between classes.',
      ),
    ],
  ),
];
