FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}
    password_confirmation {password}

    gimei = Gimei.name
    first_name            {gimei.first.kanji}
    second_name           {gimei.last.kanji}
    first_name_kana       {gimei.first.katakana}
    second_name_kana      {gimei.last.katakana}
  end
end