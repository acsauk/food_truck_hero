FactoryBot.define do
  factory :ingredient do
    name "Ingredient Name"
    association :product
  end
end
