import React from 'react';
import { useIngredients } from '../ingredientContext';


const IngredientList = () => {
  const { state } = useIngredients();
  console.log('IngredientList state:', state);
  return (
    <div>

  <ul className="space-y-2 mt-4">
    {state.ingredients.map(ingredient => (
      <li className="flex justify-between items-center border p-3 rounded">
        <span className="font-medium">{ingredient.name}</span>
        <span className="text-gray-600">{ingredient.quantity}</span>
      </li>
    ))}
  </ul>
  <p className='mt-4 mb-8 text-lg'>The list above is estimated for {state.portion} people, containing {state.calories} cal and {state.protein}g of protein.</p>
</div>)}

export default IngredientList;
