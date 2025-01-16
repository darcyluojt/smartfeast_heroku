import React from 'react';
import RecipeSwiper from '../components/RecipeSwiper';

const RecipeSwiperApp = (props) => {

  return(
    <RecipeSwiper
    initialRecipe={props.initialRecipe}
    nextUrl={props.nextUrl}/>
)};

export default RecipeSwiperApp;
