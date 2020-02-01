FactoryBot.define do
  factory :ingredient do
    association :product

    trait :two_pound_product do
      association :product, :price_two_pound
    end

    trait :three_pound_product do
      association :product, :price_three_pound
    end

    trait :use_by_days_three_product do
      association :product, :use_by_days_three
    end

    trait :use_by_days_five_product do
      association :product, :use_by_days_five
    end

    trait :use_by_days_seven_product do
      association :product, :use_by_days_seven
    end
  end
end
