FactoryGirl.define do
  factory :message do
    body        "wow, cool"
    image       Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image/image.jpg'))
    user
    group
  end
end
