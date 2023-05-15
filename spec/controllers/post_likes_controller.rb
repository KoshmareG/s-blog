require 'rails_helper'

RSpec.describe PostLikesController, type: :controller do
  let(:user) { create(:user) }
  let!(:user_post) { create(:post, user: user) }

  shared_examples 'user redirect back' do
    it 'returns response status is 302' do
      expect(response.status).to eq(302)
    end
  end

  describe '#create' do
    context 'user can like post' do
      before do
        sign_in user
        expect { post :create, params: {post_id: user_post.id} }.to change(PostLike, :count).by(1)
      end

      include_examples 'user redirect back'
    end

    context 'user can like post' do
      let!(:post_like) { PostLike.create(user_id: user.id, post_id: user_post.id) }

      before do
        sign_in user
        expect { post :create, params: {post_id: user_post.id} }.to change(PostLike, :count).by(0)
      end

      include_examples 'user redirect back'
    end
  end

  describe '#destroy' do
    let!(:post_like) { PostLike.create(user_id: user.id, post_id: user_post.id) }

    context 'user can dislike post' do
      before do
        sign_in user
        expect { delete :destroy, params: {post_id: user_post.id} }.to change(PostLike, :count).by(-1)
      end

      include_examples 'user redirect back'
    end
  end
end
