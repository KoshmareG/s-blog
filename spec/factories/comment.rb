FactoryBot.define do
  factory :comment do
    body { "Comment_#{rand(999)}" }
  end
end
