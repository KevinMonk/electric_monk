FactoryBot.define do
  factory :act do
    association :verb
    name { "MyString" }
    description { "MyText" }
  end
end
