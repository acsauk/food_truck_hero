FactoryBot.define do
  factory :meal do
    sequence :name do |n|
      "Name text #{n}"
    end
    association :user

    portions 1
    price_per_portion 1.5

    transient do
      recipes_count 2
      recipe_title 'Cooked Ham'
      recipe_instructions 'Cook that ham good'
      product_price false
      ingredients_count 2
    end

    trait :two_pound_product do
      product_price :two_pound_product
    end

    trait :three_pound_product do
      product_price :three_pound_product
    end

    factory :meal_with_recipes_with_ingredients do
      after(:create) do |meal, evaluator|
        rwi = if evaluator.product_price
                FactoryBot.create(
                  :recipe_with_ingredients,
                  evaluator.product_price,
                  user: meal.user,
                  ingredients_count: evaluator.ingredients_count
                )
              else
                FactoryBot.create(
                  :recipe_with_ingredients,
                  user: meal.user,
                  ingredients_count: evaluator.ingredients_count
                )
              end
        (0...evaluator.recipes_count).each do
          rwi.title = evaluator.recipe_title unless evaluator.recipe_title.empty?
          rwi.instructions = evaluator.recipe_instructions unless evaluator.recipe_instructions.empty?
          meal.recipeLists <<
            FactoryBot.build(
              :recipeList, recipe: rwi
            )
        end
      end
    end
  end
end
