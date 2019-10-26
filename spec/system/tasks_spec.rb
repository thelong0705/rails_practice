# frozen_string_literal: true

require 'rails_helper'

describe 'CRUD tasks', type: :system do
  describe 'show all tasks' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }

    before do
      FactoryBot.create(:task, name: 'first task', user: user_a)
      visit login_path
      fill_in 'Email', with: login_user.email
      fill_in 'Password', with: login_user.password
      click_button 'login'
    end
    context 'when user A login' do
      let(:login_user) { user_a }

      it 'show all tasks that user A created' do
        expect(page).to have_content 'first task'
      end
    end

    context 'when user B login' do
      let(:login_user) { user_b }
      it 'dont show user A created task' do
        expect(page).to have_no_content 'first task'
      end
    end
  end
end
