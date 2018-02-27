FactoryBot.define do
  factory :ingredient do
    association product
    name 'Ingredient Name'
  end
end
