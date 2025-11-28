import '../models/food_item.dart';

const mockFoodMenu = <FoodItem>[
  FoodItem(
    id: 'ecafe-coffee',
    name: 'E-Café Study Fuel',
    description: 'Medium brewed coffee from E-Café in ETB with a grab-and-go snack.',
    price: '\$2.65+',
    imageUrl:
        'https://images.pexels.com/photos/374885/pexels-photo-374885.jpeg', // coffee cup
    restaurantName: 'E-Café (ETB)',
    restaurantUrl:
        'https://hospitality.mcmaster.ca/locations/our-locations/e-cafe-menu/',
  ),
  FoodItem(
    id: 'lapiazza-slam-dunk',
    name: 'La Piazza “Slam Dunk” Breakfast',
    description:
        'Scrambled eggs, pancakes, home fries and your choice of bacon or sausage.',
    price: '\$8.25',
    imageUrl:
        'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg', // breakfast plate
    restaurantName: 'La Piazza (MUSC Student Centre)',
    restaurantUrl:
        'https://hospitality.mcmaster.ca/locations/our-locations/la-piazza-menu/',
  ),
  FoodItem(
    id: 'phoenix-burger',
    name: 'Phoenix Classic Burger & Fries',
    description:
        'Grilled burger with toppings and a side of fries at the Phoenix Crafthouse & Grill.',
    price: '\$15.00–\$18.00',
    imageUrl:
        'https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg', // burger + fries
    restaurantName: 'The Phoenix Crafthouse & Grill (Refectory)',
    restaurantUrl: 'https://www.phoenixmcmaster.com/',
  ),
];
