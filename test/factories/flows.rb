FactoryBot.define do
  factory :flow do
    association :act
    name { "MyString" }
    description { "MyText" }
  end
end
