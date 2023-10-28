import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/providers/meals_provider.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}

class FiltersProviderNotifier extends StateNotifier<Map<Filters,bool>>{
  FiltersProviderNotifier() : super({
    Filters.glutenFree : false,
    Filters.lactoseFree : false,
    Filters.vegetarian : false,
    Filters.vegan : false,
  });

  void onToggleFilters(Filters filter, bool isActive){
    state = {...state,filter : isActive};
  }
}

final filtersProvider = StateNotifierProvider<FiltersProviderNotifier, Map<Filters,bool>>((ref) => FiltersProviderNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meals) {

  if(activeFilters[Filters.glutenFree]! && !meals.isGlutenFree){
    return false;
  }
  if(activeFilters[Filters.lactoseFree]! && !meals.isLactoseFree){
    return false;
  }
  if(activeFilters[Filters.vegetarian]! && !meals.isVegetarian){
    return false;
  }
  if(activeFilters[Filters.vegan]! && !meals.isVegan){
    return false;
  }
  
  return true;
  }).toList();

  }
);