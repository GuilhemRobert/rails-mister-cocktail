class Dose < ApplicationRecord
  belongs_to :cocktail, inverse_of: :doses
  belongs_to :ingredient, inverse_of: :doses
  validates :description, presence: true
  validates :cocktail, presence: true
  validates :ingredient, presence: true
  validates :cocktail, uniqueness: {scope: :ingredient}
  accepts_nested_attributes_for :cocktail, :ingredient
end
