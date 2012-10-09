# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    title "MyString"
    image "MyString"
    position 1
    gallery nil
  end
end
