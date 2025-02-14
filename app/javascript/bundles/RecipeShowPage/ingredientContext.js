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

export function IngredientsProvider({ initialIngredients, children }) {
  const initialState = {
    ingredients: initialIngredients,
    specialRequests: [],
    portionSize: 1,
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
      default:
        return draft;
    }
  }
