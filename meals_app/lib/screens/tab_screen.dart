import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/providers/favourite_meal_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';


class TabScreen extends ConsumerStatefulWidget{
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen>{

  int _activePageIndex = 0;

  void onTapBottomNavBar(int index) {
    setState(() {
      _activePageIndex = index;
    });
  }

  void onTapDrawerItem(String indentifer) {
    Navigator.of(context).pop();

    if(indentifer=='Filters'){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeScreen = CategoriesScreen(availableMeals);
    String activeTitle = 'Category';

    if(_activePageIndex == 1){
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activeTitle = 'Favourites';
      activeScreen = MealsScreen(mealsList: favouriteMeals);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: MainDrawer(onTapDrawerItem: onTapDrawerItem),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activePageIndex,
        onTap: onTapBottomNavBar,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal_rounded), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.star),label: 'Favourites'),
        ],
      ),
    );
  }
}