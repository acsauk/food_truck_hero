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
      ingredients_count 2
      amount 1
      unit 'grams'
      ingredient_name nil
    end

    factory :recipe_with_ingredients do
      after(:create) do |recipe, evaluator|
        (0...evaluator.ingredients_count).each do
          case evaluator.ingredient_name
          when nil
            recipe.ingredientLists <<
              FactoryBot.build(
                :ingredientList, ingredient: FactoryBot.build(:ingredient, product: FactoryBot.build(:product)
              ))
          else
            recipe.ingredientLists <<
              FactoryBot.build(
                :ingredientList, ingredient:
                  FactoryBot.build(:ingredient, name: evaluator.ingredient_name, product: FactoryBot.build(:product))
              )
          end
        end
      end
    end
  end
end
