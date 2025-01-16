import React from 'react';
import { userSelector, useDispatch } from 'react-redux';
import RecipeSwiper from '../components/RecipeSwiper';
import * as actions from '../actions/recipeSwiperActionCreators';

const RecipeSwiperContainer = () => {
  console.log('RecipeSwiperContainer');
  const initialRecipe = useSelector(state => state.initialRecipe)
  return <RecipeSwiper recipe={initialRecipe} />

}

export default RecipeSwiperContainer;
