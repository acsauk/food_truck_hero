FactoryBot.define do
  factory :ingredientList do
    recipe
    ingredient
    amount 20
    unit 'grams'
  end
end
