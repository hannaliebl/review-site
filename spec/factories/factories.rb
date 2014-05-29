FactoryGirl.define do
  factory :user do
    username "seconduser"
    email "second@example.com"
    password "eightchars"
    password_confirmation "eightchars"
  end

  factory :profile do
    about "Lorem ipsum lorem ipsum"
    location "Portland, Oregon"
    lifter_type1 "0"
    lifter_type2 "1" #bodybuilder
    lifter_type3 "0"
    lifter_type4 "0"
    lifter_type5 "0"
    lifter_type6 "0"
    user
  end
end