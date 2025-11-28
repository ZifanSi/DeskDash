import '../models/food_item.dart';

const mockFoodMenu = <FoodItem>[
  FoodItem(
    id: 'combo-1',
    name: 'Study Saver Combo',
    description: 'Medium coffee + muffin. Perfect for 8AM labs.',
    price: '\$4.49',
    imageUrl:
        'https://images.pexels.com/photos/2396220/pexels-photo-2396220.jpeg', // coffee + pastry
    restaurantName: 'Campus Café North',
    restaurantUrl: 'https://www.mcdonalds.com/ca/en-ca.html',
  ),
  FoodItem(
    id: 'combo-2',
    name: 'Late Night Fries',
    description: 'Fries + soft drink for those 11PM debugging sessions.',
    price: '\$3.99',
    imageUrl:
        'https://images.pexels.com/photos/1583884/pexels-photo-1583884.jpeg', // fries
    restaurantName: 'Student Centre Grill',
    restaurantUrl: 'https://www.mcdonalds.com/ca/en-ca/full-menu.html',
  ),
  FoodItem(
    id: 'combo-3',
    name: 'Focus Box',
    description: 'Chicken wrap + iced coffee. Grab-and-go between lectures.',
    price: '\$7.29',
    imageUrl:
        'https://images.pexels.com/photos/1600711/pexels-photo-1600711.jpeg', // wrap
    restaurantName: 'Library Café Express',
    restaurantUrl: 'https://www.mcdelivery.com/', // just a mock link
  ),
];
