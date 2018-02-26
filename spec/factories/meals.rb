FactoryBot.define do
  factory :meal do
    sequence :name do |n|
      "Name text #{n}"
    end
    portions 1
    price_per_portion 1.5
    # association :recipe

    factory :meal_with_ingredients do
      association :recipe_with_ingredients
    end
  end
end
