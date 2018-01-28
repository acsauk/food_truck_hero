FactoryGirl.define do
  factory :ingredient_list do
    recipe
    ingredient
    amount "MyString"
    unit 1.5
  end
end
