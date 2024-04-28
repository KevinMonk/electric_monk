FactoryBot.define do
  factory :flow do
    association :team
    name { "MyString" }
    description { "MyText" }
  end
end
