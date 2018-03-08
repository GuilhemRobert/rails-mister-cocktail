class Ingredient < ApplicationRecord
  has_many :doses
  before_destroy :check_for_doses
  has_many :cocktails, through: :doses
  validates :name, presence: true
  validates :name, uniqueness: true

  private

  def check_for_doses
    if doses.count > 0
      raise ActiveRecord::InvalidForeignKey
      return false
    end
  end

end
