require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(140) }
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(2000) }
    it { should validate_content_type_of(:picture).allowing(%i[png jpg jpeg webp]) }
  end

  context 'associations' do
    it { should belong_to(:user) }
  end
end
