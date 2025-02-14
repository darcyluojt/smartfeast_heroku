class OpenaiService
  def self.customization(ingredients,portion,requests)
    client = OpenAI::Client.new
    prompt = <<~PROMPT
      You are a reasonable and responsible nutrition expert, your job is to customize the ingredient list based on the portion size and user needs without massively changing the recipe.
       - Portion: #{portion}
       - User needs: #{requests}
       - Ingredients list: #{ingredients}
      Skip your analyzing process. Only render back the ingredient list with the same json format but adjusting the ingredient list based on the portion size and users' needs. Nothing else.
    PROMPT
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [{role: "user", content: prompt}],
        temperature: 0.9})

    response["choices"][0]["message"]["content"]
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
