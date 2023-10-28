import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favourite_meal_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({super.key, required this.mealItem});

  final Meal mealItem;
  final IconData starIcon = Icons.star;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeal = ref.watch(favouriteMealsProvider);
    final isPresent = favouriteMeal.contains(mealItem);

    return Scaffold(
      appBar: AppBar(
        title: Text(mealItem.title),
        actions: [
          IconButton(
            onPressed: () {
              final bool isAdded = ref
                  .read(favouriteMealsProvider.notifier)
                  .onToggleFavouriteMeal(mealItem);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isAdded
                      ? 'Marked as favourite'
                      : 'Removed from favourites'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.8,end: 1.0).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isPresent ? Icons.star : Icons.star_border,
                key: ValueKey(isPresent),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: mealItem.id,
              child: Image(
                image: NetworkImage(mealItem.imageUrl),
                height: 300,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 10),
            for (final ingredient in mealItem.ingredients)
              Padding(
                padding: const EdgeInsets.all(2),
                child: Text(ingredient,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
              ),
            const SizedBox(height: 25),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 10),
            for (final ingredient in mealItem.steps)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(ingredient,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
              ),
          ],
        ),
      ),
    );
  }
}
