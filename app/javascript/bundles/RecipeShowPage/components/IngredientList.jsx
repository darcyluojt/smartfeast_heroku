import React from 'react';


const IngredientList = (object) => {
  const ingredients = object.ingredients;
  const displayList = ingredients.map(ingredient =>({id: ingredient.id,
    name: ingredient.ingredient.name,
    quantity: ingredient.quantity,
    unit: ingredient.unit}));

  return (
    <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
  {displayList.map(ingredient => (
    <div key={ingredient.id} className="p-4 border rounded">
      <p className="font-medium">{ingredient.name}</p>
      <p>{ingredient.quantity} {ingredient.unit}</p>
    </div>
  ))}
</div>
  )
}

export default IngredientList;
