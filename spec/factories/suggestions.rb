# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :suggestion do
    title "MyString"
    body "MyText"
    user nil
  end
end
