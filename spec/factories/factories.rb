FactoryGirl.define do
  factory :user do
    username "seconduser"
    email "second@example.com"
    password "eightchars"
    password_confirmation "eightchars"
  end
end