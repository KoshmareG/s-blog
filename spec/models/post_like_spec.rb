require 'rails_helper'

RSpec.describe PostLike, type: :model do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let(:post_like) { PostLike.new(post: post, user: user) }

  context 'validations' do
    subject { post_like }

    it { is_expected.to validate_uniqueness_of(:user).scoped_to(:post_id) }
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
