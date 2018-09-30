FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "testaccount#{n}@example.com" }
    sequence(:first_name) { |n| "Joe#{n}" }
    sequence(:last_name) { |n| "Bloggs#{n}" }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.now }
  end
end
