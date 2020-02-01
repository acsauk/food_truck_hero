FactoryBot.define do
  factory :recipe do
    sequence :title do |n|
      "Title text #{n}"
    end

    sequence :instructions do |n|
      "Instructions text #{n}"
    end

    association :user

    transient do
      ingredients_count { 2 }
      amount { 1 }
      unit { 'grams' }
      product_price { false }
    end

    trait :two_pound_product do
      product_price { :two_pound_product }
    end

    trait :three_pound_product do
      product_price { :three_pound_product }
    end

    factory :recipe_with_ingredients do
      after(:create) do |recipe, evaluator|
        (0...evaluator.ingredients_count).each do
          recipe.ingredient_lists <<
            if evaluator.product_price
              FactoryBot.create(
                :ingredient_list,
                ingredient: FactoryBot.create(:ingredient, evaluator.product_price)
              )
            else
              FactoryBot.create(
                :ingredient_list, ingredient: FactoryBot.create(:ingredient)
              )
            end
        end
      end
    end

    factory :recipe_3_days_ubd do
      after(:create) do |recipe, evaluator|
        recipe.ingredient_lists <<
          FactoryBot.create(
            :ingredient_list, ingredient: FactoryBot.create(:ingredient, :use_by_days_three_product)
          )

          recipe.ingredient_lists <<
          FactoryBot.create(
            :ingredient_list, ingredient: FactoryBot.create(:ingredient, :use_by_days_five_product)
          )
      end
    end

    factory :recipe_5_days_ubd do
      after(:create) do |recipe, evaluator|
        recipe.ingredient_lists <<
          FactoryBot.create(
            :ingredient_list, ingredient: FactoryBot.create(:ingredient, :use_by_days_five_product)
          )

          recipe.ingredient_lists <<
          FactoryBot.create(
            :ingredient_list, ingredient: FactoryBot.create(:ingredient, :use_by_days_seven_product)
          )
      end
    end
  end
end
