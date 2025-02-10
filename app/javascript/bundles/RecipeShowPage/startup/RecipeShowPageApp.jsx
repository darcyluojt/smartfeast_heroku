import React from 'react';
import RecipeShowPageContainer from '../containers/RecipeShowPageContainer';
import { IngredientsProvider } from '../ingredientContext';

const RecipeShowPageApp = (props) => {
  return (
    <IngredientsProvider initialIngredients={props.ingredients_recipes}>
      <RecipeShowPageContainer/>
    </IngredientsProvider>

  );
}

export default RecipeShowPageApp;
