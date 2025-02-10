import React, { createContext } from 'react';
import { useImmerReducer } from "use-immer";


export const IngredientsContext = createContext(null);

export function IngredientsProvider({ initialIngredients, children }) {
  const [ingredients, dispatch] = useImmerReducer(ingredientsReducer, initialIngredients);

  return (
    <IngredientsContext.Provider value={{ingredients, dispatch}}>
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
