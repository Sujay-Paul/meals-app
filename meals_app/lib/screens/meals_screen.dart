import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/widgets/meal_list_code.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.mealsList});

  final String? title;
  final List<Meal> mealsList;

  void _onTapMenu(BuildContext context, Meal mealItem) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(mealItem: mealItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Uh ho... nothing here",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            "Try for some another category!",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (mealsList.isNotEmpty) {
      content = ListView.builder(
        itemCount: mealsList.length,
        itemBuilder: (ctx, index) => MealListCode(
          mealItem: mealsList[index],
          onTapMenu: () {_onTapMenu(context,mealsList[index]);},
        ),
      );
    }

    if(title==null){
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
        
      ),
      body: content,
    );
  }
}
