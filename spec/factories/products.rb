FactoryBot.define do
  factory :product do
    sequence :name do |n|
      "Name #{n}"
    end
    sequence :brand do |n|
      "Brand #{n}"
    end
    unit "Grams"
    amount 1.5
    price 1.5
  end
end
