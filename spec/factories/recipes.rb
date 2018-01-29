FactoryBot.define do
  factory :recipe do
    sequence :title do |n|
      "Title text #{n}"
    end
    sequence :instructions do |n|
      "Instructions text #{n}"
    end
  end
end
