FactoryBot.define do
  factory :product do
    sequence :name do |n|
      "Name #{n}"
    end
    sequence :brand do |n|
      "Brand #{n}"
    end
    unit { 'Grams' }
    amount { 100 }
    price { 1 }

    trait :price_two_pound do
      price { 2 }
    end

    trait :price_three_pound do
      price { 3 }
    end
  end
end
