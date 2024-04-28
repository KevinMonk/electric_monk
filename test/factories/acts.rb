FactoryBot.define do
  factory :act do
    association :team
    name { "MyString" }
    description { "MyText" }
  end
end
