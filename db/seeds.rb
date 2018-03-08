# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

50.times do
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  cocktail_serialized = open(url).read
  cocktail_hash = JSON.parse(cocktail_serialized)
  drink_hash = cocktail_hash["drinks"][0]
  cocktail_name = drink_hash["strDrink"]
  cocktail = Cocktail.create(name: cocktail_name)
  (1..15).each do |i|
    code = "strIngredient" + i.to_s
    ingredient_name = drink_hash[code]
    exception = ["", " ", nil, "\r\n"]
    if exception.exclude?(ingredient_name)
      ingredient = Ingredient.create(name: ingredient_name)
      code = "strMeasure" + i.to_s
      dose_description = drink_hash[code]
      dose = Dose.new(description: dose_description)
      dose.cocktail = cocktail
      dose.ingredient = ingredient
      dose.save
    end
  end
end
