import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavouriteMealsNotifer extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifer() : super([]);

  bool onToggleFavouriteMeal(Meal meal){
    final bool mealIsFavourite = state.contains(meal);

    if(mealIsFavourite){
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    }
    else {
      state = [...state,meal];
      return true;
    }
  } 
}

final favouriteMealsProvider = StateNotifierProvider<FavouriteMealsNotifer,List<Meal>>((ref) => FavouriteMealsNotifer());