FactoryBot.define do
  factory :shopping_list do
    association :user

    sequence :name do |n|
      "Name #{n}"
    end

    transient do
      meals_count { 2 }
      meal_name { 'Spicy chicken wraps' }
      meal_portions { 4 }
      meal_price_per_portion_pence { 250 }
    end

    factory :shopping_list_with_meals_with_recipes_with_ingredients do
      after(:create) do |shopping_list, evaluator|
        mwrwi = FactoryBot.create(
          :meal_with_recipes_with_ingredients,
          :two_pound_product,
          recipes_count: 3,
          ingredients_count: 1
        )

        (0...evaluator.meals_count).each do
          mwrwi.name = evaluator.meal_name
          mwrwi.portions = evaluator.meal_portions
          shopping_list.meal_lists <<
            FactoryBot.build(
              :meal_list, meal: mwrwi
            )
        end
      end
    end
  end
end
