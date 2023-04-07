import 'package:flutter/material.dart';
import 'package:shop_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  Function addToFavourite;
  Function alreadyFavourated;
  MealDetailScreen(this.alreadyFavourated, this.addToFavourite);
  Widget categoryTextWidget(String text, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget CategoryList(Widget child) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String argId = ModalRoute.of(context)?.settings.arguments as String;
    final categoryItem = DUMMY_MEALS.firstWhere((meal) => meal.id == argId);
    return Scaffold(
      appBar: AppBar(title: Text(categoryItem.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                categoryItem.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            categoryTextWidget('Ingradients', context),
            CategoryList(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(categoryItem.ingredients[index]),
                    ),
                  );
                },
                itemCount: categoryItem.ingredients.length,
              ),
            ),
            categoryTextWidget('Steps', context),
            CategoryList(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            '# ${index + 1}',
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          categoryItem.steps[index],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
                itemCount: categoryItem.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          alreadyFavourated(argId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          addToFavourite(argId);
        },
      ),
    );
  }
}
