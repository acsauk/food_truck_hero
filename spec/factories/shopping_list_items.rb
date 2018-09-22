FactoryBot.define do
  factory :shopping_list_item do
    
    sequence :name do |n|
        "Item #{n}"
    end
    
    unit 'Grams'
    amount 100
    purchased false

    trait :purchased_item do
      purchased true
    end
  end
end