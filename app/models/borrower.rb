class Borrower < ActiveRecord::Base
  has_secure_password
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password,
            length: { minimum: 6 }
  validates :first_name,
            :last_name,
            :email,
            :money_needed,
            :money_purpose,
            presence: true
end
