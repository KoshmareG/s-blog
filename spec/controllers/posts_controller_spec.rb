require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let!(:user_post) { create(:post, user: user) }
  let(:another_user) { create(:user) }
  let(:post_params) do
    {title: 'New post', body: 'Post body'}
  end

  shared_examples 'forbid access for not authorized' do
    it 'redirect to new user session' do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  shared_examples 'allow access for authorized' do
    it 'returns response status is 200' do
      expect(response.status).to eq(200)
    end
  end

  describe '#new' do
    context 'when not authorized user' do
      before { get :new }

      include_examples 'forbid access for not authorized'
    end

    context 'when authorized user' do
      before do
        sign_in user
        get :new
      end

      include_examples 'allow access for authorized'
    end
  end

  describe '#create' do
    context 'when not authorized user' do
      before { expect { post :create, params: {post: post_params} }.to change(Post, :count).by(0) }

      include_examples 'forbid access for not authorized'
    end

    context 'when authorized user' do
      before do
        sign_in user
        expect { post :create, params: {post: post_params} }.to change(Post, :count).by(1)
      end

      it 'returns response status is 302' do
        expect(response.status).to eq(302)
      end
    end
  end

  describe '#edit' do
    context 'when not authorized user' do
      before { get :edit, params: {id: user_post.id} }

      include_examples 'forbid access for not authorized'
    end

    context 'when authorized user' do
      before do
        sign_in user
        get :edit, params: {id: user_post.id}
      end

      include_examples 'allow access for authorized'
    end
  end

  describe '#update' do
    context 'when not authorized user' do
      before do
        put :update, params: {id: user_post.id, post: post_params}
      end

      include_examples 'forbid access for not authorized'
    end

    context 'when post owner' do
      before do
        sign_in user
        put :update, params: {id: user_post.id, post: post_params}
      end

      it 'redirect to user post' do
        expect(response).to redirect_to(post_path(user_post))
      end
    end
  end

  describe '#destroy' do
    context 'when not authorized user' do
      before { expect { delete :destroy, params: {id: user_post.id} }.to change(Post, :count).by(0) }

      include_examples 'forbid access for not authorized'
    end

    context 'when authorized user' do
      before do
        sign_in user
        expect { delete :destroy, params: {id: user_post.id} }.to change(Post, :count).by(-1)
      end

      it 'redirect to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
