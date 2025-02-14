class OpenaiService
  def self.customization(ingredients, portion, requests, initial_calories, initial_protein)
    client = OpenAI::Client.new
    prompt = <<~PROMPT
      This is the ingredinent list for a recipe containing #{initial_calories} calories and #{initial_protein}grams of protein.
      - Ingredient list: #{ingredients}
      Adjust the ingredient list based on the portion size and user needs below
       - Portion: #{portion} average healthy adult(s). Each eat 450~600 calories per meal.
       - User needs: #{requests}
      Based on the adjust ingredient list, calculate the total calories and protein for the new meal. Skip the analysing process. Only return back the adjusted calories, protein and ingredient list in a JSON object. See example below:
      {
      "calories": 1500,
      "protein": 75,
      "ingredients": [
    {
      "name": "Olive Oil",
      "quantity": "2 tbs"
    },
    {
      "name": "Onion",
      "quantity": "1 sliced"
  }]
      }
    PROMPT
    Rails.logger.info(prompt)
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [{role: "user", content: prompt}],
        temperature: 0.9})

    response["choices"][0]["message"]["content"]
  end

  def self.estimation(recipe)
    client = OpenAI::Client.new
    prompt = <<~PROMPT
      You are a responsible nutrition expert, your job is to estimate the nutritional values of a recipe. Here is the recipe:
      #{recipe}
      Skip your analyzing process. Only render back estimated servings for an average healthy adult who eats 450 - 600 cal per meal, total calories(kcal) and total protein(g) in json format. See example below. Nothing else.
      {
      "servings": 3,
      "calories": 1500,
      "protein": 50
      }
    PROMPT
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [{role: "user", content: prompt}],
        temperature: 0.9})
    response = response["choices"][0]["message"]["content"]
    JSON.parse(response, symbolize_names: true)
  end

  # def self.get_recommendations(profile_data)
  #     client = OpenAI::Client.new
  #     prompt = <<~PROMPT
  #       You are a responsible nutrition expert, your job is to provide recommendations to your clients based on their profile data. Here is the profile data of a client:
  #       - Gender: #{profile_data["gender"]}
  #       - Height: #{profile_data["height"]}cm
  #       - Weight: #{profile_data["weight"]}kg
  #       - Age: #{Time.now.year} - #{profile_data["date_of_birth"]}
  #       - Meals per day: #{profile_data["meals_per_day"]}
  #       - Fitness goal: #{profile_data["fitness_goal"]}
  #       - Meal plan: #{profile_data["meal_plan"]}

  #       1g protein and 1g carbs are 4 calories each. 1g fat is 9 calories. If client chooses high protein, they should consume 1.2~1.7g of protein per kg of body weight. If fitness goal is weight loss, they should consume 5% less than their maintenance calories.
  #       Return only these values in this format. Nothing else
  #       Calories_per_day: [number]
  #       Protein_per_day: [number]g
  #       Carbs_per_day: [number]g
  #     PROMPT

  #   response = client.chat(
  #     parameters: {
  #       model: "gpt-4o-mini",
  #       messages: [{role: "user", content: prompt}],
  #     temperature: 0.7,
  #   })
  #   parse_response(response["choices"][0]["message"]["content"])
  # end

  #   def self.parse_response(response)
  #     hash = response.split("\n").map { |line| line.split(": ") }.to_h
  #     hash.transform_keys! { |key| key.downcase }
  #     hash.transform_values! do |value|
  #       value.scan(/\d+/).first.to_i
  #     end
  #     hash
  #   end
end
