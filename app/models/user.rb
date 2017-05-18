class User < ApplicationRecord
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9\_\-\.]+\z/

  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :username,    presence: true,
                          format: { with: VALID_USERNAME_REGEX },
                          uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :user_remember_tokens

  class << self
    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def remember
    token = UserRememberToken.new(user: self, remember_digest: User.new_token)
    self.user_remember_tokens << token
    token.remember_digest
  end

  def remembered_by_token?(token)
    UserRememberToken.find_by(user: self.id, remember_digest: token)
  end

  # Forgets a user.
  def forget_remember_token(token)
    UserRememberToken.where(remember_digest: token, user: self).destroy_all
  end

  def forget_all_remember_tokens
    UserRememberToken.where(user: self).destroy_all
  end
end
