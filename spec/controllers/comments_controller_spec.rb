require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, user: user) }
  let(:post_params) do
    {post_id: user_post.id, comment: {body: 'Test comment'}}
  end

  shared_examples 'forbid access for not authorized' do
    it 'redirect to new user session' do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe '#create' do
    context 'when not authorized user' do
      before { expect { post :create, params: post_params }.to change(Comment, :count).by(0) }

      include_examples 'forbid access for not authorized'
    end

    context 'when authorized user' do
      before do
        sign_in user
        expect { post :create, params: post_params }.to change(Comment, :count).by(1)
      end

      it 'returns response status is 302' do
        expect(response).to redirect_to(post_path(user_post))
      end
    end
  end

  describe '#destroy' do
    let!(:comment) { create(:comment, post: user_post, user: user) }

    context 'when not authorized user' do
      before { expect { delete :destroy, params: {post_id: user_post.id, id: comment.id} }.to change(Comment, :count).by(0) }

      include_examples 'forbid access for not authorized'
    end

    context 'when authorized user' do
      before do
        sign_in user
        expect { delete :destroy, params: {post_id: user_post.id, id: comment.id} }.to change(Comment, :count).by(-1)
      end

      it 'redirect to root path' do
        expect(response).to redirect_to(post_path(user_post))
      end
    end
  end
end
