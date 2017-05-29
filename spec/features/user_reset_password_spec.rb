require 'rails_helper'

RSpec.feature 'User Reset Password', type: :feature do
  let!(:user) { FactoryGirl.create(:user, password: 'testpassword') }
  let!(:email) { FactoryGirl.create(:email_address, user: user) }

  before(:each) do
    ActionMailer::Base.deliveries = []
  end

  scenario 'User requests reset to correct username' do
    fill_in_reset_form(user.username)
    expect(page).to have_content('Email sent with password reset instructions')
    expect(ActionMailer::Base.deliveries.size).to eq 1
  end

  scenario 'User requests reset to incorrect username' do
    fill_in_reset_form('notacredential')
    expect(page).to have_content('Incorrect details entered')
    expect(ActionMailer::Base.deliveries.size).to eq 0
  end

  scenario 'User submits valid token' do
    submit_valid_token
    expect(page).to have_content 'Token valid'
  end

  scenario 'User submits invalid token' do
    fill_in_reset_form(user.username)
    visit password_reset_token_path
    user.reload
    fill_in 'Password reset token', with: 'notatoken'
    click_button 'Submit Token'
    expect(page).to have_content 'Token not found'
  end

  scenario 'User successfully resets password' do
    submit_valid_token
    fill_in 'Password', with: 'newpassword1'
    fill_in 'Confirmation', with: 'newpassword1'
    click_button 'Update password'
    expect(page).to have_content 'Password changed'
    expect(ActionMailer::Base.deliveries.size).to eq 2
  end

  scenario 'User unsuccessfully resets password with non matching passwords' do
    submit_valid_token
    fill_in 'Password', with: 'newpassword1'
    fill_in 'Confirmation', with: 'newpassword2'
    click_button 'Update password'
    expect(page).to have_content 'Password confirmation doesn\'t match Password'
    expect(ActionMailer::Base.deliveries.size).to eq 1
  end

  scenario 'User unsuccessfully resets password with blank password' do
    submit_valid_token
    fill_in 'Password', with: ''
    fill_in 'Confirmation', with: ''
    click_button 'Update password'
    expect(page).to have_content 'Password must be entered'
    expect(ActionMailer::Base.deliveries.size).to eq 1
  end

  private

  def fill_in_reset_form(credential)
    visit root_path
    click_link 'Log in'
    click_link 'Forgot Password?'
    fill_in 'Username', with: credential
    click_button 'Request Password Reset'
  end

  def submit_valid_token
    fill_in_reset_form(user.username)
    visit password_reset_token_path
    user.reload
    fill_in 'Password reset token', with: user.password_reset_token
    click_button 'Submit Token'
  end
end
