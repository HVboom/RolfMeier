# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    title "MyString"
    slug "MyString"
    short_text "MyText"
    long_text "MyText"
    maintainer "MyString"
    content_type "MyString"
    content "MyText"
    menu nil
  end
end
