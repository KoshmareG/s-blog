require 'rails_helper'

RSpec.describe PostPolicy do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:another_user) { create(:user) }

  subject { described_class }

  context 'user can create new post' do
    permissions :new?, :create? do
      it 'allow access to create new post' do
        expect(subject).to permit(user, Post.new)
      end

      it 'forbid access to create new post' do
        expect(subject).not_to permit(nil, Post.new)
      end
    end
  end

  context 'user can edit update destroy own post' do
    permissions :edit?, :update?, :destroy? do
      it 'allow access for post owner' do
        expect(subject).to permit(user, post)
      end
    end
  end

  context 'another user cannot edit update destroy stranger post' do
    permissions :edit?, :update?, :destroy? do
      it 'forbid access for another user' do
        expect(subject).not_to permit(another_user, post)
      end
    end
  end
end
