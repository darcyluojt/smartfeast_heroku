import React from 'react';

const HelloWorld = ({ name, updateName }) => {
  return (
  <div className="hello-world-container">
      <h3>
        Hello, {name}!
      </h3>
      <hr />
      <form>
        <label htmlFor="name">
          Say hello to:
          <input
            id="name"
            type="text"
            value={name}
            onChange={(e) => updateName(e.target.value)}
          />
        </label>
      </form>
    </div>
  )
}

export default HelloWorld;
