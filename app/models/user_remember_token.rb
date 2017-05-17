class UserRememberToken < ApplicationRecord
  belongs_to :user

  validates :remember_digest, presence: true
end
