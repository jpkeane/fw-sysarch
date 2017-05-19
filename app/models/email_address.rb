class EmailAddress < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  belongs_to :user, inverse_of: :email_addresses

  validates :email_address, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :user, presence: true
  validates :primary, uniqueness: { scope: :user_id, message: 'User already has a primary email' }, if: :primary

  before_create :make_primary_when_none

  def make_primary
    return unless self.user.email_addresses.count > 1
    old_primary = EmailAddress.find_by(user: user, primary: true)
    old_primary.update(primary: false)
    self.update(primary: true)
  end

  # def send_welcome_email
  #  RegistrationMailer.welcome_email(self).deliver_now
  # end

  private

  def make_primary_when_none
    return if self.user.email_addresses.where(primary: true).any?
    self.primary = true
  end
end
