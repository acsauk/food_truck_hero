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
      title 'Cooked Ham'
      instructions 'Cook that ham good'
    end

    factory :meal_with_recipes_with_ingredients do
      after(:create) do |meal, evaluator|
        rwi = FactoryBot.create(:recipe_with_ingredients, user: meal.user)
        (0...evaluator.recipes_count).each do
          case evaluator.title
          when nil
            meal.recipeLists <<
              FactoryBot.build(
                :recipeList, recipe: rwi
              )
          else
            rwi.title = evaluator.title
            meal.recipeLists <<
              FactoryBot.build(
                :recipeList, recipe: rwi
              )
          end
        end
      end
    end
  end
end
