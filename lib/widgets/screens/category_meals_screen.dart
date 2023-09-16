import 'package:flutter/material.dart';
import 'package:shop_app/models/meals.dart';
import 'package:shop_app/widgets/meal_item.dart';


class CategoryMealsScreen extends StatefulWidget {
  // final String id;
  // final String title;
  // CategoryMealsScreen(this.id, this.title);
  List<Meal> categoryMealUpdated;
  static const routeName = '/category-meals';
  CategoryMealsScreen(this.categoryMealUpdated);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String title;
  late List<Meal> categoryMeal;
  var check = false;
  @override
  void didChangeDependencies() {
    if (!check) {
      final routArg =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      title = routArg['title'] as String;
      final String id = routArg['id'] as String;
      categoryMeal = widget.categoryMealUpdated.where(
        (element) {
          return element.categories.contains(id);
        },
      ).toList();
      check = true;
    }
    super.didChangeDependencies();
  }

  void _deleteItem(String id) {
    setState(() {
      categoryMeal.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: categoryMeal[index].id,
            title: categoryMeal[index].title,
            imageUrl: categoryMeal[index].imageUrl,
            affordability: categoryMeal[index].affordability,
            complexity: categoryMeal[index].complexity,
            duration: categoryMeal[index].duration,
          );
        },
        itemCount: categoryMeal.length,
      ),
    );
  }
}
