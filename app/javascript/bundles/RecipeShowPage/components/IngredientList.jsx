import React from 'react';
import { useIngredients } from '../ingredientContext';


const IngredientList = () => {
  const { state } = useIngredients();
  console.log('IngredientList state:', state);
  return (
    <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
      {state.ingredients.map(ingredient => (
        <div key={ingredient.id} className="border p-2">
          <p className="font-medium">{ingredient.name}</p>
          <p>{ingredient.quantity} {ingredient.unit}</p>
        </div>))}
  </div>)}

export default IngredientList;
