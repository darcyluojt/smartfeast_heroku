import React from 'react';
import RecipeShowPageContainer from '../containers/RecipeShowPageContainer';
import { IngredientsProvider } from '../ingredientContext';

const RecipeShowPageApp = (props) => {
  console.log("Props in RecipeShowPageApp:", props);
  const ingredientsList = props.ingredients_recipes;
  const portion = props.servings;
  const protein = props.protein;
  const calories = props.calories;
  const displayList = ingredientsList.map(ingredient=>({
    name: ingredient.ingredient.name,
    quantity: ingredient.quantity}));

  return (
    <IngredientsProvider
    initialIngredients={displayList}
    initialPortion={portion}
    initialProtein={protein}
    initialCalories={calories}>
      <RecipeShowPageContainer/>
    </IngredientsProvider>

  );
}

export default RecipeShowPageApp;
