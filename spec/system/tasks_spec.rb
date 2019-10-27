# frozen_string_literal: true

require 'rails_helper'

describe 'CRUD tasks', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'user A', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'user B', email: 'b@example.com') }
  let!(:task_a) { FactoryBot.create(:task, name: 'first task', user: user_a) }

  before do
    visit login_path
    fill_in 'Email', with: login_user.email
    fill_in 'Password', with: login_user.password
    click_button 'login'
  end

  shared_examples_for 'show created task of user A' do
    it { expect(page).to have_content 'first task' }
  end

  describe 'show all tasks' do
    context 'when user A login' do
      let(:login_user) { user_a }
      it_behaves_like 'show created task of user A'
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

      it_behaves_like 'show created task of user A'
    end
  end

  describe 'create new task' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in 'Name', with: task_name
      click_button 'Create Task'
    end

    context 'enter name when create task' do
      let(:task_name) { 'task name' }

      it 'will create task' do
        expect(page).to have_selector '.alert-success', text: 'task name'
      end
    end

    context 'not enter name when create task' do
      let(:task_name) { '' }

      it 'will not create task' do
        within '#error_explanation' do
          expect(page).to have_content "Name can't be blank"
        end
      end
    end
  end
end
