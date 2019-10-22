require 'rails_helper'

describe 'CRUD tasks', type: :system do
  describe 'show all tasks' do
    before do
      user_a = FactoryBot.create(:user, name: 'user A', email: 'a@example.com')
      FactoryBot.create(:task, name: 'first task', user: user_a)
    end
    context 'when user A login' do
      before do
        visit login_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: 'password'
        click_button 'login'
      end

      it 'show all tasks that user A created' do
        expect(page).to have_content 'first task'
      end
    end
  end
end