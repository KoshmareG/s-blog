FactoryBot.define do
  factory :post do
    title { "Test_post_#{rand(999)}" }
    body { "Test_post_body_#{rand(999)}" }
  end
end
