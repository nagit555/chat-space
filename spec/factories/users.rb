FactoryGirl.define do
  factory :user do
    name                    "voldo"
    sequence(:email) {Faker::Internet.email}
    password                "12345678"
    password_confirmation   "12345678"
  end
end
