FactoryBot.define do
  factory :shopping_list_item do
    association :shopping_list
    purchased false
  end
end
