FactoryGirl.define do
  factory :message do
    body        "wow, cool"
    image       File.open("#{Rails.root}/spec/fixtures/image/over.jpg")
    user
    group
  end
end
