require 'rails_helper'

RSpec.feature 'User Login and Logout', type: :feature do
  let(:user) { FactoryGirl.create(:user, password: 'testpassword') }

  scenario 'User logs in successfully with username' do
    successful_sign_in
    expect(page).to have_content('Log in successful')
    expect(Capybara.current_session.driver.request.cookies['remember_token']).to be_nil
  end

  scenario 'User logs in successfully then visits login page' do
    successful_sign_in
    visit login_path
    expect(page).to have_content('You are already logged in')
  end

  scenario 'User logs in with remembering' do
    successful_sign_in(remember: true)
    expect(Capybara.current_session.driver.request.cookies['remember_token']).not_to be_nil
    successful_log_out
    expect(Capybara.current_session.driver.request.cookies['remember_token']).to be_nil
  end

  scenario 'User logs in unsuccessfully' do
    visit root_path
    click_link 'Log in'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: 'notthepassword'
    click_button 'Log in'
    expect(page).to have_content('Invalid username or password ')
  end

  scenario 'User logs out successfully' do
    successful_sign_in
    successful_log_out
    # visit dashboard_path
    # expect(page).to have_content('You are not logged in')
  end

  def successful_sign_in(options = {})
    visit root_path
    click_link 'Log in'
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    check('session_remember_me') if options[:remember]
    click_button 'Log in'
  end

  def successful_log_out
    click_link 'Log out'
    expect(page).to have_link('Log in')
    expect(page).to have_content('Log out successful')
  end
end
