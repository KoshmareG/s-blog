FactoryBot.define do
  factory :user do
    email { "test_user_#{rand(999)}@example.com" }
    username { "User_#{rand(999)}" }
    after(:build) { |u| u.password_confirmation = u.password = 'Password123456' }
  end
end
