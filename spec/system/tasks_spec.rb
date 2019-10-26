# frozen_string_literal: true

require 'rails_helper'

describe 'CRUD tasks', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'user A', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'user B', email: 'b@example.com') }
  let!(:task_a) { FactoryBot.create(:task, name: 'first task', user: user_a) }

  before do
    # FactoryBot.create(:task, name: 'first task', user: user_a)
    visit login_path
    fill_in 'Email', with: login_user.email
    fill_in 'Password', with: login_user.password
    click_button 'login'
  end

  describe 'show all tasks' do
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

  describe 'task details' do
    context 'when user A login' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it 'show task detail' do
        expect(page).to have_content 'first task'
      end
    end
  end
end
