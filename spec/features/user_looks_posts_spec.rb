require 'rails_helper'

RSpec.feature 'user looks posts', type: :feature do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:user_post) { create(:post, user: user, title: 'User post title', body: 'User post body') }
  let!(:another_user_post) { create(:post, user: user, title: 'Another user post title', body: 'Another user post body') }

  before do
    login_as user
    visit posts_path
  end

  scenario 'user sees all posts' do
    expect(page).to have_content('User post title')
    expect(page).to have_content('User post body')
    expect(page).to have_content('Another user post title')
    expect(page).to have_content('Another user post body')
  end
end
