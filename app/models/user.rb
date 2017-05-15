class User < ApplicationRecord
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9\_\-\.]+\z/

  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :username,    presence: true,
                          format: { with: VALID_USERNAME_REGEX },
                          uniqueness: { case_sensitive: false }
  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end
end
