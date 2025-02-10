import React, { useContext } from 'react';
import { IngredientsContext } from '../ingredientContext';
import IngredientList from '../components/IngredientList';
// import SpecialRequest from '../components/SpecialRequest';

const RecipeShowPageContainer = () => {
  const { ingredients, dispatch } = useContext(IngredientsContext);

  return(
  <div>
      <IngredientList ingredients={ingredients}/>
      {/* <SpecialRequest/> */}
    </div>
  );
};

export default RecipeShowPageContainer;
