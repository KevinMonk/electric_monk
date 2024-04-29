FactoryBot.define do
  factory :operand do
    association :act
    name { "MyString" }
    description { "MyText" }
  end
end
