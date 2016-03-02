FactoryGirl.define do
  factory :user do
    firstname "John"
    lastname "Doe"
    password_digest "add8ftwfge67w23gddfe8x8d21d1sd"
    email "jd@gmail.com"
    password "test12"
    session
  end

  factory :user_admin, parent: :user do
    admin true
  end
end