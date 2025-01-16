
import React, { useState }  from 'react';
// import * as style from './RecipeSwiper.module.css';
import { useSwipeable } from 'react-swipeable';


const RecipeSwiper = ({ initialRecipe, nextUrl }) => {
  const [currentRecipe, setCurrentRecipe] = useState(initialRecipe);

  const fetchNextRecipe = () => {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    fetch(nextUrl, {
      method: 'GET',
      headers: {
        'X-CSRF-Token': csrfToken
      }
    })
      .then(response => response.json())
      .then(newRecipe => {
        setCurrentRecipe(newRecipe);
      })
      .catch(error => {
        console.error('Error:', error);
      });
  }

  const createMeal = (recipe) =>{
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    fetch('/meals', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({
        meal: {
          recipe_id: recipe.id,
          date: new Date()
        }
      })
    })
    .then(response =>
      {if (response.ok) {
        window.location.href = response.url;
      }
    })
    .then(data => {
      if (data.status === 200) {

        window.location.replace(data.basket_url)}})
    .catch((error) => {
      console.error('Error:', error);
    });
  }

  const handlers = useSwipeable({
    onSwipedLeft: () => fetchNextRecipe(),
    onSwipedRight: ()=>createMeal(currentRecipe),
    onSwiping: (eventData) => {
      console.log('Swiping...', eventData.dir);
    },
    preventDefaultTouchmoveEvent: true,
    delta: 50,
    trackMouse: true,
  });

  const categories = Object.values(currentRecipe.category).join(', ');
  const main = currentRecipe.ingredients_recipes.slice(0,6)
  const ingredients = main.map(element => element.ingredient.name).join(', ');
  const link = `/recipes/${currentRecipe.id}`;
  const style= {
      backgroundImage: `url(${currentRecipe.thumbnail}), linear-gradient(rgba(0,0,0,1), rgba(0,0,0,0.5))`,
      backgroundSize: 'cover',
      backgroundPosition: 'center',
      backgroundRepeat: 'no-repeat',
      height: "75vh",
      width: '100%',
      margin: '8px auto',
      borderRadius: '15px',
      hover: 'hover:bg-gray-100',
      shadow: '0 4px 6px 0 rgba(0, 0, 0, 0.1)',
      border: '1px solid #e5e7eb',
      transition: 'all 0.3s',
      maxWidth: '460px',
      maxHeight: '920px',
    }

    const linkStyle = {
      display: 'flex',
      justifyContent: 'space-between',
      flexDirection: 'column',
    }

  return (
    <div {...handlers} style={style}>
      <a href={link}  className="recipe-card group relative block h-full
      overflow-hidden shadow-lg hover:shadow-xl transition-shadow duration-300" style={linkStyle}>
        <div className="relative p-4 sm:p-6 lg:p-8 bg-black bg-opacity-25 rounded-xl">
          <p className="text-xl font-bold text-white sm:text-2xl text-center drop-shadow-xl">{currentRecipe.name}</p>
          <p className="text-sm font-medium uppercase tracking-widest  text-pink-500 w-full flex justify-center">{categories}</p>

        </div>

        <div
        className="p-4 text-black sm:p-6 lg:p-8 overflow-hidden bg-black bg-opacity-25 rounded-xl">

          <p className="text-sm text-white drop-shadow-xl"><strong>Main ingredients: </strong></p>
          <p className="text-sm text-white drop-shadow-xl">{ingredients}</p>
          <br/>
          <p className="text-sm text-white drop-shadow-lg shadow-black">
          <strong>Instructions: </strong>{ingredients}{currentRecipe.steps.substring(0, currentRecipe.steps.indexOf('.') + 1)}......
          </p>
        </div>
      </a>
    </div>
  )

};


export default RecipeSwiper;
