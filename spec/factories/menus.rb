# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :menu do
    title "MyString"
    position 1
    parent nil
  end
end
