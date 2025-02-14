import React from 'react';
import { useIngredients } from '../ingredientContext';

const SpecialRequest = () => {
  const requests = ['High protein', 'Post workout', 'Low carbs', 'Vegetarian']
  const {state, dispatch} = useIngredients();
  const ingredientList = state.ingredients;
  const handleSubmit = async (e) => {
    e.preventDefault();
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    const formData = new FormData(e.target);
    const params = {
      portion: formData.get('portion'),
      initialCalories: state.calories,
      initialProtein: state.protein,
      requests: formData.getAll('selectedRequests'),
      ingredients: ingredientList,
    }
    const response = await fetch("/api/customization", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify(params)
    });
    if (!response.ok) {
      throw new Error('Failed to get customized ingredients');}
    const parsedResponse = await response.json();
    const customizedIngredients = parsedResponse.ingredients;
    const customizedCalories = parsedResponse.calories;
    const customizedProtein = parsedResponse.protein;
    console.log('Customized ingredients', customizedIngredients);
    dispatch({ type: 'UPDATE_INGREDIENTS', payload: customizedIngredients });
    dispatch({ type: 'UPDATE_PORTION', payload: parseInt(formData.get('portion')) });
    dispatch({ type: 'UPDATE_REQUESTS', payload: formData.getAll('selectedRequests') });
    dispatch({ type: 'UPDATE_CALORIES', payload: customizedCalories });
    dispatch({ type: 'UPDATE_PROTEIN', payload: customizedProtein });


  }

  return(
<div className="max-w-md mx-auto p-6 bg-white rounded-lg shadow-md my-8">
  <h3 className="text-center text-lg font-semibold text-brand-green mb-4">
    Want to customise your meal?
  </h3>

  <form onSubmit={handleSubmit} className="space-y-6">
    {/* Portion size with inline layout */}
    <div className="flex items-center space-x-4">
      <label className="text-brand-green font-medium whitespace-nowrap">
        Portion size:
      </label>
      <input
        type="number"
        name="portion"
        defaultValue="1"
        className="w-20 rounded-md border-gray-300 shadow-sm focus:border-brand-orange focus:ring-brand-orange"
      />
    </div>
    <div className="flex">
    {requests.map(request => (
        <label key={request} className="flex items-center">
          <input
            type="checkbox"
            name="selectedRequests"
            value={request}
            className="rounded border-gray-300 text-blue-600 font-medium focus:ring-blue-500 mr-2"
          />
          <span className="text-sm text-gray-700">{request}</span>
        </label>
      ))}
    </div>


    <button
      type="submit"
      className="w-full bg-brand-orange text-white py-2 px-4 rounded-md hover:bg-brand-green focus:outline-none focus:ring-2 focus:ring-brand-orange focus:ring-offset-2 transition-colors font-medium"
    >
      Customize
    </button>
  </form>
</div>
  )
}

export default SpecialRequest;
