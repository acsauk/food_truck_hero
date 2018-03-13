FactoryBot.define do
  factory :ingredient do
    association :product
    name 'Ingredient Name'

    trait :two_pound_product do
      association :product, :price_two_pound
    end

    trait :three_pound_product do
      association :product, :price_three_pound
    end
  end
end
