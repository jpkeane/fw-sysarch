require 'rails_helper'

RSpec.feature 'User Registration', type: :feature do
  let(:user) { FactoryGirl.build(:user, password: 'testpassword') }
  let(:email_address) { FactoryGirl.build(:email_address, user: user) }

  before(:each) do
    ActionMailer::Base.deliveries = []
  end

  scenario 'User registers with valid details' do
    visit root_path
    click_link 'Register'
    fill_in 'Username', with: user.username
    fill_in 'First name', with: user.first_name
    fill_in 'Last name', with: user.last_name
    fill_in 'Email address', with: email_address.email_address
    fill_in 'Location', with: user.location
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Register'
    expect(page).to have_content('Account created successfully')
    expect(ActionMailer::Base.deliveries.size).to eq 1
  end

  scenario 'User registers with invalid details' do
    pre_deliveries = ActionMailer::Base.deliveries.size
    visit root_path
    click_link 'Register'
    fill_in 'Username', with: user.username
    fill_in 'First name', with: user.first_name
    fill_in 'Last name', with: user.last_name
    fill_in 'Email address', with: email_address.email_address
    fill_in 'Password', with: user.password
    click_button 'Register'
    expect(page).to have_content('There was a problem with your registration')
    expect(ActionMailer::Base.deliveries.size).to eq pre_deliveries
  end
end
