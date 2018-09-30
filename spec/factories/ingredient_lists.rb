FactoryBot.define do
  factory :ingredient_list do
    recipe
    ingredient
    amount { 20 }
    unit { 'grams' }
  end
end
