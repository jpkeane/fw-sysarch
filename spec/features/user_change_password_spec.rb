require 'rails_helper'

RSpec.feature 'User Change Password', type: :feature do
  let(:user) { FactoryGirl.create(:user, password: 'testpassword') }
  let(:email) { FactoryGirl.create(:email_address, user: user) }

  scenario 'User logs in and edits password successfully' do
    successful_sign_in
    click_link 'Edit Profile'
    click_link 'Password'
    fill_in 'Current password', with: user.password
    fill_in 'Password', with: 'NewTestPass'
    fill_in 'Password confirmation', with: 'NewTestPass'
    click_button 'Change Password'
    expect(page).to have_content('Password changed')
    user.reload
    expect(user.authenticate('NewTestPass')).to be_truthy
  end

  def successful_sign_in
    visit root_path
    click_link 'Log in'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
