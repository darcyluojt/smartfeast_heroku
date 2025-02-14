require "json"
require "open-uri"
require "openai"
require "dotenv/load"

url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=53085"
uri = URI.parse(url).read
recipe = JSON.parse(uri)["meals"][0]
client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
prompt = <<~PROMPT
      You are a responsible nutrition expert, your job is to estimate the nutritional values of a recipe. Here is the recipe:
      #{recipe}
      Skip your analyzing process. Only render back estimated servings, total calories(kcal) and total protein(g) in json format. See example below. Nothing else.
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
estimation = response["choices"][0]["message"]["content"]
estimation = JSON.parse(estimation, symbolize_names: true)
p estimation
