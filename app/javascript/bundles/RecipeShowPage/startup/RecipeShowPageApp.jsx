import React from 'react';
import RecipeShowPageContainer from '../containers/RecipeShowPageContainer';
import { IngredientsProvider } from '../ingredientContext';

const RecipeShowPageApp = (props) => {
  // console.log("Props in RecipeShowPageApp:", props);
  const ingredientsList = props.ingredients_recipes;
  const displayList = ingredientsList.map(ingredient=>({
    id:   ingredient.id,
    name: ingredient.ingredient.name,
    calories_per_100g: ingredient.ingredient.calories_unit,
    protein_per_100g: ingredient.ingredient.protein_unit,
    quantity: ingredient.quantity,
    unit: ingredient.unit}));
  return (
    <IngredientsProvider initialIngredients={displayList}>
      <RecipeShowPageContainer/>
    </IngredientsProvider>

  );
}

export default RecipeShowPageApp;
