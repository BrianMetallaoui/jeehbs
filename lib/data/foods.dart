import 'package:jeehbs/models/models.dart';

List<Food> foods = [
  Food(
    name: 'Beef',
    caloriesPerServing: 120,
    totalCalories: 1200,
    servings: 10,
    ingredients: [
      Ingredient(
        calories: 300,
        name: 'Love',
        servingSize: 'Test',
        amount: 2,
      )
    ],
  ),
  Food(
    name: 'Chicken',
    caloriesPerServing: 300,
    totalCalories: 600,
    servings: 2,
    ingredients: [
      Ingredient(
        calories: 300,
        name: 'Love',
        servingSize: 'Test',
        amount: 2,
      )
    ],
  ),
  Food(
    name: 'Pork and beef',
    caloriesPerServing: 350,
    totalCalories: 1050,
    servings: 3,
    ingredients: [
      Ingredient(
        calories: 300,
        name: 'Love',
        servingSize: 'Test',
        amount: 2,
      )
    ],
  ),
  Food(
    name: 'Rice',
    caloriesPerServing: 500,
    totalCalories: 2000,
    servings: 2,
    ingredients: [
      Ingredient(
        calories: 300,
        name: 'Love',
        servingSize: 'Test',
        amount: 2,
      )
    ],
  ),
];
