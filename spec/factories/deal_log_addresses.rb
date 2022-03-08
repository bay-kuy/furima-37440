FactoryBot.define do
  factory :deal_log_address do
    postcode         {'123-4567'}
    prefecture_id    {14}
    city             {'横浜市緑区'}
    numbers          {'青山1-1-1'}
    building         {'柳ビル103'}
    telephone_number {Faker::Number.number(digits: 11)}
  end
end
