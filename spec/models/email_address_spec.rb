require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
  describe 'attributes' do
    it { is_expected.to have_attribute :email_address }
    it { is_expected.to have_attribute :primary }

    it 'should ensure that the first email address added for a user is primary' do
      user = FactoryGirl.create(:user)
      email1 = FactoryGirl.create(:email_address, user: user)
      expect(email1.primary?).to be_truthy
      email2 = FactoryGirl.create(:email_address, user: user)
      expect(email2.primary?).to be_falsey
    end
  end

  describe 'relationships' do
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :email_address }
    it { is_expected.to validate_presence_of :user }

    it 'should check valid email addresses' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        contact = FactoryGirl.build(:email_address, email_address: invalid_address)
        expect(contact).not_to be_valid
      end
    end

    it 'should check that there can only be one primary email' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:email_address, user: user, primary: true)

      second_email = FactoryGirl.build(:email_address, user: user, primary: true)
      expect(second_email).not_to be_valid
    end
  end

  describe 'methods' do
    it '#make_primary should make email primary and remove others' do
      user = FactoryGirl.create(:user)
      first_email = FactoryGirl.create(:email_address, user: user)
      second_email = FactoryGirl.create(:email_address, user: user)
      expect(second_email.primary).to be_falsey
      second_email.make_primary
      first_email.reload
      second_email.reload
      expect(second_email.primary).to be_truthy
      expect(first_email.primary).to be_falsey
    end
  end
end
