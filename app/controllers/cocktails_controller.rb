class CocktailsController < ApplicationController

def index
  @cocktails = Cocktail.all
end

def show
  @cocktail = Cocktail.find(params[:id])
end

def new
  @ingredient = Ingredient.new
  @dose = Dose.new
  @cocktail = Cocktail.new
end

def create
  @cocktail = Cocktail.create(cocktail_params)
  @ingredient = Ingredient.find(ingredient_params[:ingredient_ids])
  @dose = Dose.new(description: dose_params[:description])
  @dose.cocktail = @cocktail
  @dose.ingredient = @ingredient
  @dose.save
  @cocktail.save
  raise
  redirect_to cocktail_path(@cocktail)
end

private

def cocktail_params
  params.require(:cocktail).permit(:name)
end

def dose_params
  params.require(:cocktail).require(:dose).permit(:description)
end

def ingredient_params
  params.require(:cocktail).permit(:ingredient_ids)
end

end
