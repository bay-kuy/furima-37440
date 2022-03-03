FactoryBot.define do
  factory :item do
    name {Faker::Name.initials(number: 3)}
    description {Faker::Lorem.sentence}
    category { Category.all.sample }
    condition { Condition.all.sample }
    postage { Postage.all.sample }
    prefecture { Prefecture.all.sample }
    ship_date { ShipDate.all.sample }
    price {Faker::Number.between(from: 300, to: 9999999)}

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
