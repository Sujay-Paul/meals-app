import 'package:flutter/material.dart';

import 'package:meals_app/models/category.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid(
      {super.key, required this.categoryItem, required this.onSelectCategory});

  final Category categoryItem;
  final Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                categoryItem.color.withOpacity(0.55),
                categoryItem.color.withOpacity(0.9)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Text(
          categoryItem.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
