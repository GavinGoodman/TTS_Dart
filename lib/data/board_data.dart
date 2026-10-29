import 'package:flutter/material.dart';

/*
This file is strictly pertaining to the board information for the communication
device. In essence, a board is referred to as the tiles a user can press in the
application. These are built to move back adn forth as well, being utilized as
a shallow board, one that cannot go into another category, and a deep board
which means the tiles can be pressed to move into deeper, more detailed words
for the category. These were made beforehand and structured via the design
and implemented after into the application. In the first section of this, we
have the class for the board information, all the variables needed to create
and operational board and the next is a constructor of the board with five
required variables and two nonrequired variables. Next, we have the creation
of each individual board used in this application. Lastly again, the board
is similar to a tree with branching directions and ability to return to the root
through the application.
 */

class BoardItemInfo {
  final String id; // acts as teh key to link to the tile
  final String label; // acts as the word put in sentence and spoken
  final IconData image; // icon image relating to word
  final Color color; // color of tile (all will be white background)
  final Color iconColor; // specific icon image
  final bool isCategory; // if it is a broad tree that branches deeper
  final List<BoardItemInfo> subtree; // child tiles related to category

  const BoardItemInfo({
    required this.id, // required for id of tile to link to tile use
    required this.label, // required to word in sentence and spoken word
    required this.image, // required tile image for word image link for user
    required this.color, // required background tile creation
    required this.iconColor, // required image icon color for individual words
    this.isCategory = false, // specifies if tile is a category for more boards
    this.subtree = const [], // children tiles for broad boards
  });
}

/*
This section is the specific board information for the boards created in this
ACC application. I will explain each board generally because they are identical
in formation. This is where the constructor is called and creates categories and
tiles for each work.
 */

const List<BoardItemInfo> baseBoard = [
  // This is the first board screen the
  BoardItemInfo(
    // user will see. This one is for food
    id: 'food', // options and is a category
    label: 'Food',
    image: Icons.restaurant,
    color: Colors.white,
    iconColor: Colors.blueGrey,
    isCategory: true,
    subtree: [
      _fruitsBoard,
      _vegetablesBoard,
      _entreesBoard,
      _snacksBoard,
      _drinksBoard,
    ],
  ),
  BoardItemInfo(
    // This board category is one for feelings
    id: 'feelings',
    label: 'Feelings',
    image: Icons.sentiment_neutral_sharp,
    color: Colors.white,
    iconColor: Colors.amber,
    isCategory: true,
    subtree: _feelingsBoard,
  ),
  BoardItemInfo(
    // This board category is utilized for activities
    id: 'activities',
    label: 'Activities',
    image: Icons.directions_bike,
    color: Colors.white,
    iconColor: Colors.green,
    isCategory: true,
    subtree: _activitiesBoard,
  ),
  BoardItemInfo(
    // This board category is used for people
    id: 'people',
    label: 'People',
    image: Icons.people,
    color: Colors.white,
    iconColor: Colors.amber,
    isCategory: true,
    subtree: _peopleBoard,
  ),
  BoardItemInfo(
    // This board category is for places
    id: 'places',
    label: 'Places',
    image: Icons.location_city,
    color: Colors.white,
    iconColor: Colors.black87,
    isCategory: true,
    subtree: _placesBoard,
  ),
  BoardItemInfo(
    // This board category is for I need statements
    id: 'I need', // This is for the user to say I need help, I
    label: 'I need', // need a break, I need to go, etc.
    image: Icons.waving_hand,
    color: Colors.white,
    iconColor: Colors.amber,
    isCategory: true,
    subtree: _iNeedBoard,
  ),
  BoardItemInfo(
    // This is the board category for decisions, so the
    id: 'decision', // user can type yes, no, and maybe
    label: 'Decision',
    image: Icons.handshake,
    color: Colors.white,
    iconColor: Colors.amber,
    isCategory: true,
    subtree: _decisionsBoard,
  ),
  BoardItemInfo(
    // This board category is for the user to ask general
    id: 'questions', // questions like who, how, when, what, why, etc.
    label: 'Questions',
    image: Icons.question_mark,
    color: Colors.white,
    iconColor: Colors.blueGrey,
    isCategory: true,
    subtree: _questionsBoard,
  ),
];

/*
This is the more in-depth food category options for the user, this will host
another set of food options and categories for the user to branch into and
select. We have fruits, vegetables, entrees, snacks, and drinks.
 */
const BoardItemInfo _fruitsBoard = BoardItemInfo(
  id: 'fruits', // This is the board category for the fruits tree
  label: 'Fruits',
  image: Icons.apple,
  color: Colors.white,
  iconColor: Colors.blueGrey,
  isCategory: true,
  subtree: _fruitWords,
);

const BoardItemInfo _vegetablesBoard = BoardItemInfo(
  id: 'vegetable', // This is the board category for the vegetables tree
  label: 'Vegetables',
  image: Icons.grass,
  color: Colors.white,
  iconColor: Colors.green,
  isCategory: true,
  subtree: _vegetableWords,
);

const BoardItemInfo _snacksBoard = BoardItemInfo(
  id: 'snacks', // This is the board category for the snacks tree
  label: 'Snacks',
  image: Icons.cookie,
  color: Colors.white,
  iconColor: Colors.brown,
  isCategory: true,
  subtree: _snackWords,
);

const BoardItemInfo _drinksBoard = BoardItemInfo(
  id: 'drinks', // This is the board category for the drinks tree
  label: 'Drinks',
  image: Icons.local_drink,
  color: Colors.white,
  iconColor: Colors.blue,
  isCategory: true,
  subtree: _drinkWords,
);

const BoardItemInfo _entreesBoard = BoardItemInfo(
  id: 'entrees', // This is the board category for the entrees tree
  label: 'Entrees',
  image: Icons.dinner_dining,
  color: Colors.white,
  iconColor: Colors.redAccent,
  isCategory: true,
  subtree: _entreeWords,
);

/*
This is the last child tree of the food and fruits tree. It will host the fruit
options for the users and will not be another category for the user to go into.
 */
const List<BoardItemInfo> _fruitWords = [
  BoardItemInfo(
    id: 'apple', // This is the apple tile for the user
    label: 'Apple',
    image: Icons.apple,
    color: Colors.white,
    iconColor: Colors.redAccent,
  ),
  BoardItemInfo(
    id: 'banana', // This is the banana tile for the user
    label: 'Banana',
    image: Icons.energy_savings_leaf,
    color: Colors.white,
    iconColor: Colors.yellow,
  ),
  BoardItemInfo(
    id: 'orange', // This is the orange tile for the user
    label: 'Orange',
    image: Icons.circle,
    color: Colors.white,
    iconColor: Colors.orangeAccent,
  ),
  BoardItemInfo(
    id: 'grapes', // This is the grapes tile for the user
    label: 'Grapes',
    image: Icons.circle,
    color: Colors.white,
    iconColor: Colors.purple,
  ),
  BoardItemInfo(
    id: 'berry', // This is the berry tile for the user.
    label: 'Berries',
    image: Icons.favorite_outlined,
    color: Colors.white,
    iconColor: Colors.pink,
  ),
];

/*
This is the vegetables category the user can select into, it hosts a variety of
vegetables.
 */
const List<BoardItemInfo> _vegetableWords = [
  BoardItemInfo(
    id: 'carrot', // This is the carrot tile for the user to pick.
    label: 'Carrot',
    image: Icons.linear_scale,
    color: Colors.white,
    iconColor: Colors.deepOrangeAccent,
  ),
  BoardItemInfo(
    id: 'broccoli', // This is the broccoli tile for the user
    label: 'Broccoli',
    image: Icons.park,
    color: Colors.white,
    iconColor: Colors.green,
  ),
  BoardItemInfo(
    id: 'corn', // This is the corn tile for the user
    label: 'Corn',
    image: Icons.grass_outlined,
    color: Colors.white,
    iconColor: Colors.yellowAccent,
  ),
  BoardItemInfo(
    id: 'potato', // This is the potato tile for the user
    label: 'Potato',
    image: Icons.circle,
    color: Colors.white,
    iconColor: Colors.brown,
  ),
];

/*
This is the board category for the snack foods information. This will host all
of the individual snack words the user can select once entering the category.
 */
const List<BoardItemInfo> _snackWords = [
  BoardItemInfo(
    id: 'chips', // This is the chips tile for the user
    label: 'Chips',
    image: Icons.token_rounded,
    color: Colors.white,
    iconColor: Colors.yellow,
  ),
  BoardItemInfo(
    id: 'cookie', // This is the cookie tile for the user
    label: 'Cookie',
    image: Icons.cookie,
    color: Colors.white,
    iconColor: Colors.brown,
  ),
  BoardItemInfo(
    id: 'crackers', // This is the crackers tile for the user
    label: 'Crackers',
    image: Icons.grid_view,
    color: Colors.white,
    iconColor: Colors.amberAccent,
  ),
  BoardItemInfo(
    id: 'popcorn', // This is the popcorn tile for the user
    label: 'Popcorn',
    image: Icons.movie,
    color: Colors.white,
    iconColor: Colors.amber,
  ),
  BoardItemInfo(
    id: 'peanuts', // This is the peanuts tile option for the user
    label: 'Peanuts',
    image: Icons.scatter_plot,
    color: Colors.white,
    iconColor: Colors.amberAccent,
  ),
  BoardItemInfo(
    // This is the fries tile for the user to select
    id: 'fries',
    label: 'Fries',
    image: Icons.candlestick_chart,
    color: Colors.white,
    iconColor: Colors.amber,
  ),
];

/*
This is the drinks category for the user to choose from. It will allow the user
to select and speak a few drinks.
 */
const List<BoardItemInfo> _drinkWords = [
  BoardItemInfo(
    // This is the water tile for the user to select.
    id: 'water',
    label: 'Water',
    image: Icons.water_drop,
    color: Colors.white,
    iconColor: Colors.cyanAccent,
  ),
  BoardItemInfo(
    // This is the mile tile for the user
    id: 'milk',
    label: 'Milk',
    image: Icons.coffee,
    color: Colors.blue,
    iconColor: Colors.grey,
  ),
  BoardItemInfo(
    id: 'juice', // This is the juice selection for the user
    label: 'Juice',
    image: Icons.coffee,
    color: Colors.white,
    iconColor: Colors.yellowAccent,
  ),
  BoardItemInfo(
    id: 'coffee', // This is the coffee tile for the user
    label: 'Coffee',
    image: Icons.coffee,
    color: Colors.white,
    iconColor: Colors.brown,
  ),
  BoardItemInfo(
    id: 'soda', // This is the soda tile for the user to select
    label: 'Soda',
    image: Icons.emoji_food_beverage,
    color: Colors.white,
    iconColor: Colors.deepOrange,
  ),
];

/*
This is the entree category selection for the user. This will host the last
tree tiles for tne entree food selections the user can select.
 */
const List<BoardItemInfo> _entreeWords = [
  BoardItemInfo(
    // This will be the burger tile for the user
    id: 'burger',
    label: 'Burger',
    image: Icons.fastfood,
    color: Colors.white,
    iconColor: Colors.brown,
  ),
  BoardItemInfo(
    // This will be the cheeseburger selection for the user
    id: 'cheeseburger',
    label: 'Cheeseburger',
    image: Icons.fastfood,
    color: Colors.white,
    iconColor: Colors.orange,
  ),
  BoardItemInfo(
    // This is the chicken tile selection for the user
    id: 'chicken',
    label: 'Chicken',
    image: Icons.set_meal,
    color: Colors.white,
    iconColor: Colors.pinkAccent,
  ),
  BoardItemInfo(
    // This is the fish tile selection for the user
    id: 'fish',
    label: 'Fish',
    image: Icons.set_meal,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
  BoardItemInfo(
    // This is the pasta tile selection for the user
    id: 'pasta',
    label: 'Pasta',
    image: Icons.ramen_dining,
    color: Colors.white,
    iconColor: Colors.yellowAccent,
  ),
  BoardItemInfo(
    id: 'pizza', // This is the pizza tile for the user
    label: 'Pizza',
    image: Icons.local_pizza,
    color: Colors.white,
    iconColor: Colors.redAccent,
  ),
];

/*
This is the feelings board category for the user. This will not host more categories
so it will host the feeling selections for the user to chose from in the app.
 */
const List<BoardItemInfo> _feelingsBoard = [
  BoardItemInfo(
    id: 'happy', // This is the happy tile selection
    label: 'Happy',
    image: Icons.sentiment_very_satisfied_sharp,
    color: Colors.white,
    iconColor: Colors.amber,
  ),
  BoardItemInfo(
    id: 'sad', // This is the sad tile selection
    label: 'Sad',
    image: Icons.sentiment_very_dissatisfied_sharp,
    color: Colors.white,
    iconColor: Colors.amber,
  ),
  BoardItemInfo(
    id: 'angry', // This is the angry tile selection
    label: 'Angry',
    image: Icons.sentiment_dissatisfied_sharp,
    color: Colors.white,
    iconColor: Colors.amber,
  ),
  BoardItemInfo(
    id: 'tired', // This is the tired tile selection for the user
    label: 'Tired',
    image: Icons.bedtime,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
  BoardItemInfo(
    id: 'excited', // This is the excited tile for the user
    label: 'Excited',
    image: Icons.celebration,
    color: Colors.white,
    iconColor: Colors.redAccent,
  ),
  BoardItemInfo(
    id: 'scared', // This is the scared tile for the user to select
    label: 'Scared',
    image: Icons.warning_amber,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
];

/*
This is the activities category board for the user. Like the previous, it does
not host more categories for the user to select. It will host the tiles for
activities for the user to select.
 */
const List<BoardItemInfo> _activitiesBoard = [
  BoardItemInfo(
    id: 'eat', // This is the eat tile activity for the user
    label: 'Eat',
    image: Icons.restaurant,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
  BoardItemInfo(
    id: 'sleep', // This is the sleep tile activity for the user
    label: 'Sleep',
    image: Icons.bed,
    color: Colors.white,
    iconColor: Colors.black,
  ),
  BoardItemInfo(
    id: 'play', // This is the play tile for the user to select
    label: 'Play',
    image: Icons.sports_soccer,
    color: Colors.white,
    iconColor: Colors.black,
  ),
  BoardItemInfo(
    id: 'park', // This is the park activity selection for the user
    label: 'Park',
    image: Icons.park,
    color: Colors.white,
    iconColor: Colors.green,
  ),
  BoardItemInfo(
    id: 'color', // This is the coloring tile activity for the user
    label: 'Color',
    image: Icons.design_services,
    color: Colors.white,
    iconColor: Colors.lightBlue,
  ),
  BoardItemInfo(
    id: 'paint', // This is the painting tile for the user to select
    label: 'Paint',
    image: Icons.brush,
    color: Colors.white,
    iconColor: Colors.deepPurple,
  ),
  BoardItemInfo(
    id: 'watch tv', // This is the watch tv selection for the user
    label: 'Watch TV',
    image: Icons.tv,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
  BoardItemInfo(
    id: 'music', // This is the music tile for the user to select
    label: 'Music',
    image: Icons.music_note,
    color: Colors.white,
    iconColor: Colors.black,
  ),
];

/*
This is the people category for the user to select and speak a few defined,
general peoples words. It does not host anymore categories and will host
a few tiles of people the user can select and speak.
 */
const List<BoardItemInfo> _peopleBoard = [
  BoardItemInfo(
    id: 'mom', // This is the mom tile
    label: 'Mom',
    image: Icons.face_3_outlined,
    color: Colors.white,
    iconColor: Colors.amber,
  ),
  BoardItemInfo(
    id: 'dad', // This is the dad tile for the user
    label: 'Dad',
    image: Icons.face,
    color: Colors.white,
    iconColor: Colors.amber,
  ),
  BoardItemInfo(
    id: 'friend', // This is the friend tile for the user to select
    label: 'Friend',
    image: Icons.people_alt,
    color: Colors.white,
    iconColor: Colors.amber,
  ),
  BoardItemInfo(
    id: 'teacher', // THis is the teacher tile for the user to select
    label: 'Teacher',
    image: Icons.school,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
  BoardItemInfo(
    id: 'doctor', // This is the doctor tile for the user
    label: 'Doctor',
    image: Icons.medical_services,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
];

/*
This is the places category for the user to click into to see multiple tiles
to pick from on places to go to or speak. Additionally, there were no other
categories to choose from in this tree as well.
 */
const List<BoardItemInfo> _placesBoard = [
  BoardItemInfo(
    id: 'home',
    label: 'Home', // THis is the home tile selection option
    image: Icons.home,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
  BoardItemInfo(
    // This is the school tile in the places category
    id: 'school',
    label: 'School',
    image: Icons.school,
    color: Colors.white,
    iconColor: Colors.black,
  ),
  BoardItemInfo(
    // This is the park selection for the users
    id: 'park',
    label: 'Park',
    image: Icons.park,
    color: Colors.white,
    iconColor: Colors.green,
  ),
  BoardItemInfo(
    // This is the store tile option for the users.
    id: 'store',
    label: 'Store',
    image: Icons.store,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
  BoardItemInfo(
    // This will be the outside selection for the user
    id: 'outside',
    label: 'Outside',
    image: Icons.wb_sunny,
    color: Colors.white,
    iconColor: Colors.yellowAccent,
  ),
];

/*
This is the I need category tiles from the home screen. The user will be met
with numerous options to choose from and there will not be another category
 */
const List<BoardItemInfo> _iNeedBoard = [
  BoardItemInfo(
    id: 'help', // THis is the i need help tile for the user
    label: 'Help',
    image: Icons.help,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
  BoardItemInfo(
    id: 'bathroom', // This is the bathroom selection for the user
    label: 'Bathroom',
    image: Icons.wash,
    color: Colors.white,
    iconColor: Colors.lightBlue,
  ),
  BoardItemInfo(
    id: 'break', // THis is the I need a break tile
    label: 'Break',
    image: Icons.local_cafe,
    color: Colors.white,
    iconColor: Colors.brown,
  ),
  BoardItemInfo(
    // This is the I need quiet button for the user
    id: 'quiet',
    label: 'Quiet',
    image: Icons.volume_off_outlined,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
  BoardItemInfo(
    // This is the I need to stop tile for the user
    id: 'stop',
    label: 'Stop',
    image: Icons.block,
    color: Colors.white,
    iconColor: Colors.redAccent,
  ),
  BoardItemInfo(
    // This is the I need to go tile for the user
    id: 'go',
    label: 'Go',
    image: Icons.arrow_forward,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
];

/*
This is the decision board category for the user to select. This will host some
tiles for the user to select to make general decisions like yes, no, maybe, etc.
 */
const List<BoardItemInfo> _decisionsBoard = [
  BoardItemInfo(
    // This is the yes selection for ths user
    id: 'yes',
    label: 'Yes',
    image: Icons.thumb_up,
    color: Colors.white,
    iconColor: Colors.amber,
  ),
  BoardItemInfo(
    id: 'no', // This is the no tile for the user to select
    label: 'No',
    image: Icons.thumb_down,
    color: Colors.white,
    iconColor: Colors.amber,
  ),
  BoardItemInfo(
    id: 'maybe', // This is the maybe selection for the user
    label: 'Maybe',
    image: Icons.help,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
];

/*
This is the questions board category for the user to select into. The user here
can select from a set of general questions to speak on the device. Specifically,
this is who, what, where, when, why, and how tiles for the user.
 */
const List<BoardItemInfo> _questionsBoard = [
  BoardItemInfo(
    id: 'who',
    label: 'Who',
    image: Icons.account_circle,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
  BoardItemInfo(
    id: 'what',
    label: 'What',
    image: Icons.info,
    color: Colors.white,
    iconColor: Colors.grey,
  ),
  BoardItemInfo(
    id: 'when',
    label: 'When',
    image: Icons.schedule,
    color: Colors.white,
    iconColor: Colors.grey,
  ),
  BoardItemInfo(
    id: 'where',
    label: 'Where',
    image: Icons.location_on,
    color: Colors.white,
    iconColor: Colors.redAccent,
  ),
  BoardItemInfo(
    id: 'why',
    label: 'Why',
    image: Icons.psychology,
    color: Colors.white,
    iconColor: Colors.orangeAccent,
  ),
  BoardItemInfo(
    id: 'how',
    label: 'How',
    image: Icons.settings,
    color: Colors.white,
    iconColor: Colors.blueGrey,
  ),
];
