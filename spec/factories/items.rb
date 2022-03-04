FactoryBot.define do
  factory :item do
    name          {Faker::Name.initials(number: 3)}
    description   {Faker::Lorem.sentence}
    category_id   { 2 }
    condition_id  { 2 }
    postage_id    { 2 }
    prefecture_id { 2 }
    ship_date_id  { 2 }
    price         {Faker::Number.between(from: 300, to: 9999999)}

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
