FactoryGirl.define do
  factory :user do
    username "seconduser"
    email "second@example.com"
    password "eightchars"
    password_confirmation "eightchars"
  end

  factory :profile do
    about "I play my enemies like a game of chess"
    location "Portland, Oregon"
    type_of_lifter "Powerlifter"
    user
  end
end