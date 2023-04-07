import 'package:flutter/material.dart';
import 'package:shop_app/models/meals.dart';

import '../meal_item.dart';

class FavouriteScreen extends StatelessWidget {
  final List<Meal> favouriteMeal;
  FavouriteScreen(this.favouriteMeal);

  @override
  Widget build(BuildContext context) {
    return favouriteMeal.isEmpty
        ? Center(
            child: Text('You have not marked any meal as Favourite'),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                id: favouriteMeal[index].id,
                title: favouriteMeal[index].title,
                imageUrl: favouriteMeal[index].imageUrl,
                affordability: favouriteMeal[index].affordability,
                complexity: favouriteMeal[index].complexity,
                duration: favouriteMeal[index].duration,
              );
            },
            itemCount: favouriteMeal.length,
          );
  }
}
