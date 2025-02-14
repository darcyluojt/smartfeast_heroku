import React, { createContext, useContext } from 'react';
import { useImmerReducer } from "use-immer";


export const IngredientsContext = createContext(null);

export function useIngredients() {
  const context = useContext(IngredientsContext);
  if (!context) {
    throw new Error('useIngredients must be used within an IngredientsProvider');
  }
  return context;
}

export function IngredientsProvider({ initialIngredients, initialPortion, initialCalories, initialProtein, children }) {
  const initialState = {
    ingredients: initialIngredients,
    requests: [],
    portion: initialPortion,
    protein: initialProtein,
    calories: initialCalories
  }
  const [state, dispatch] = useImmerReducer(ingredientsReducer, initialState);

  return (
    <IngredientsContext.Provider value={{state, dispatch}}>
      {children}
    </IngredientsContext.Provider>
  )
}

function ingredientsReducer(draft,action){
    switch(action.type){
      case 'UPDATE_INGREDIENTS':
        draft.ingredients = action.payload;
        break;
      case 'UPDATE_PORTION':
        draft.portion = action.payload;
        break;
      case 'UPDATE_REQUESTS':
        draft.requests = action.payload;
        break;
      case 'UPDATE_CALORIES':
        draft.calories = action.payload;
        break;
      case 'UPDATE_PROTEIN':
        draft.protein = action.payload;
        break;
      default:
        return draft;
    }

  }
