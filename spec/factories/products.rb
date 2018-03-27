FactoryBot.define do
  factory :product do
    sequence :name do |n|
      "Name #{n}"
    end
    sequence :brand do |n|
      "Brand #{n}"
    end
    unit 'Grams'
    amount 100
    price_pence 1

    trait :price_two_pound do
      price_pence 2
    end

    trait :price_three_pound do
      price_pence 3
    end
  end
end
