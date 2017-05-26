require 'rails_helper'

RSpec.feature 'User Change Password', type: :feature do
  let!(:user) { FactoryGirl.create(:user, password: 'testpassword') }
  let!(:email) { FactoryGirl.create(:email_address, user: user) }

  before(:each) do
    ActionMailer::Base.deliveries = []
  end

  scenario 'User logs in and edits password successfully' do
    successful_sign_in_and_navigate
    fill_in 'Current password', with: user.password
    fill_in 'Password', with: 'NewTestPass'
    fill_in 'Password confirmation', with: 'NewTestPass'
    submit_password('Password changed')
    expect(user.authenticate('NewTestPass')).to be_truthy
    expect(ActionMailer::Base.deliveries.size).to eq 1
  end

  scenario 'User logs in and edits password with wrong current password' do
    successful_sign_in_and_navigate
    click_link 'Edit Profile'
    click_link 'Password'
    fill_in 'Current password', with: 'NotThePassword'
    fill_in 'Password', with: 'NewTestPass'
    fill_in 'Password confirmation', with: 'NewTestPass'
    submit_password('Current password is incorrect')
    expect(user.authenticate('NewTestPass')).not_to be_truthy
    expect(ActionMailer::Base.deliveries.size).to eq 0
  end

  scenario 'User logs in and edits password with correct current password but no new password' do
    successful_sign_in_and_navigate
    fill_in 'Current password', with: user.password
    submit_password('Password must be entered')
    expect(user.authenticate(user.password)).to be_truthy
    expect(ActionMailer::Base.deliveries.size).to eq 0
  end

  scenario 'User logs in and edits password with correct current password but invalid new password' do
    successful_sign_in_and_navigate
    fill_in 'Current password', with: user.password
    fill_in 'Password', with: 'inv'
    fill_in 'Password confirmation', with: 'inv'
    submit_password('Password is too short')
    expect(user.authenticate(user.password)).to be_truthy
    expect(ActionMailer::Base.deliveries.size).to eq 0
  end

  def successful_sign_in_and_navigate
    visit root_path
    click_link 'Log in'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Log in'
    click_link 'Edit Profile'
    click_link 'Password'
  end

  def submit_password(expected_response)
    click_button 'Change Password'
    expect(page).to have_content(expected_response)
    user.reload
  end
end
