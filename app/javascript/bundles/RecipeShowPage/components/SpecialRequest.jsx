import React from 'react';
import { useIngredients } from '../ingredientContext';

const SpecialRequest = () => {
  const requests = ['high protein', 'post workout', 'low carbs', 'vegetarian']
  const {state, dispatch} = useIngredients();
  const ingredientList = state.ingredients;
  const handleSubmit = async (e) => {
    e.preventDefault();
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    const formData = new FormData(e.target);
    const params = {
      ingredients: ingredientList,
      portion: formData.get('portion'),
      requests: formData.getAll('selectedRequests')
    }
    const response = await fetch("/api/customization", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify(params)
    });
    console.log('Raw response:', response);
    if (!response.ok) {
      throw new Error('Failed to get customized ingredients');}
    const customizedIngredients = await response.json();
    console.log('Customized ingredients', customizedIngredients);
    dispatch({ type: 'UPDATE_INGREDIENTS', payload: customizedIngredients });

  }

  return(
<div className="max-w-md mx-auto p-6 bg-white rounded-lg shadow-md">
  <form
  onSubmit={handleSubmit}
  className="space-y-4"
  >
    <div className="flex flex-col">
      <label className="block text-sm font-medium text-gray-700 mb-1">
        Portion size:
        <input
          type="number"
          name="portion"
          defaultValue="1"
          className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"
        />
      </label>
    </div>

    <div className="flex">
    {requests.map(request => (
        <label key={request} className="flex items-center">
          <input
            type="checkbox"
            name="selectedRequests"
            value={request}
            className="rounded border-gray-300 text-blue-600 focus:ring-blue-500 mr-2"
          />
          <span className="text-sm text-gray-700">{request}</span>
        </label>
      ))}
    </div>

    <button
      type="submit"
      className="w-full bg-black text-white py-2 px-4 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition-colors"
    >
      Customize
    </button>
  </form>
</div>
  )
}

export default SpecialRequest;
