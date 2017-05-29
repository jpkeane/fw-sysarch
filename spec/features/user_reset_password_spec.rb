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

  private

  def fill_in_reset_form(credential)
    visit root_path
    click_link 'Log in'
    click_link 'Forgot Password?'
    fill_in 'Username', with: credential
    click_button 'Request Password Reset'
  end
end
