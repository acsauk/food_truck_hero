FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "testaccount#{n}@example.com" }
    password "password"
    password_confirmation "password"
    confirmed_at Time.now
  end
end
