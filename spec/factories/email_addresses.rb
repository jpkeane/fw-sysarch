FactoryGirl.define do
  factory :email_address do
    user
    email_address { Faker::Internet.email("#{user.first_name} #{user.last_name}") }
    primary false
  end
end
