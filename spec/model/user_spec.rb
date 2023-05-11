require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_length_of(:username).is_at_most(36) }
    it { should validate_uniqueness_of(:username) }
  end

  context 'associations' do
    it { should have_many(:posts) }
  end
end
