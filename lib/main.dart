import 'package:flutter/material.dart';
import 'package:shop_app/dummy_data.dart';
import 'package:shop_app/widgets/screens/filters_screen.dart';
import 'package:shop_app/widgets/screens/tabs_screen.dart';
import './widgets/screens/category_meals_screen.dart';
import './widgets/screens/category_screens.dart';
import './widgets/screens/meal_detail_screen.dart';
import 'models/meals.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'lactose': false,
    'glutan': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeal = DUMMY_MEALS;
  List<Meal> _favouriteMeal = [];
  void _addToFavourite(String id) {
    var isExist = _favouriteMeal.indexWhere((meal) {
      return meal.id == id;
    });
    if (isExist >= 0) {
      setState(() {
        _favouriteMeal.removeAt(isExist);
      });
    } else
      _favouriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == id));
  }

  bool _isAlreadyFavourited(String id) {
    return _favouriteMeal.any((meal) => meal.id == id);
  }

  void _applyFilters(Map<String, bool> currFilters) {
    setState(() {
      _filters = currFilters;
      availableMeal = DUMMY_MEALS.where((meal) {
        if (!meal.isGlutenFree && _filters['glutan'] == true) {
          return false;
        }
        if (!meal.isLactoseFree && _filters['lactose'] == true) {
          return false;
        }
        if (!meal.isVegan && _filters['vegan'] == true) {
          return false;
        }
        if (!meal.isVegetarian && _filters['vegetarian'] == true) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleLarge: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
      ),
      // home: CategoryScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favouriteMeal),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeal),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_isAlreadyFavourited, _addToFavourite),
        FiltersScreen.routeName: (ctx) =>
            FiltersScreen(_filters, _applyFilters),
      },
      // onGenerateRoute: (settings) {
      // if(settings.name=='/sff')return ..
      //   return MaterialPageRoute(builder: (ctx) {
      //     return CategoryScreen();
      //   });
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) {
            return CategoryScreen();
          },
        );
      },
    );
  }
}
