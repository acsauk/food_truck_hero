FactoryBot.define do
  factory :product do
    sequence :name do |n|
      "Product Name #{n}"
    end

    sequence :brand do |n|
      "Brand #{n}"
    end

    unit { 'Grams' }
    amount { 100 }
    price { 1 }
    use_by_days { 1 }

    trait :price_two_pound do
      price { 2 }
    end

    trait :price_three_pound do
      price { 3 }
    end

    trait :use_by_days_three do 
      use_by_days { 3 }
    end

    trait :use_by_days_five do 
      use_by_days { 5 }
    end

    trait :use_by_days_seven do 
      use_by_days { 7 }
    end
  end
end
