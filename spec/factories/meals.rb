FactoryBot.define do
  factory :meal do
    sequence :name do |n|
      "Name text #{n}"
    end
    portions 1
    price_per_portion 1.5

    transient do
      recipes_count 2
      title 'Cooked Ham'
      instructions 'Cook that ham good'
    end

    factory :meal_with_recipes do
      after(:create) do |meal, evaluator|
        (0...evaluator.recipes_count).each do
          case evaluator.title
          when nil
            meal.recipeLists <<
              FactoryBot.build(
                :recipeList, recipe: FactoryBot.build(:recipe)
              )
          else
            meal.recipeLists <<
              FactoryBot.build(
                :recipeList, recipe:
                  FactoryBot.build(:recipe, title: evaluator.title)
              )
          end
        end
      end
    end
  end
end
