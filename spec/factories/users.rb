FactoryBot.define do
  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"1q1q1q"}
    password_confirmation {password}
    family_name           {"阿部"}
    last_name             {"太郎"}
    family_katakana       {"アベ"}
    last_katakana         {"タロウ"}
    birthday              {19970812}
  end
end

# birthdayはどうやって値を入力すればいい？