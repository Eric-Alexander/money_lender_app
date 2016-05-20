class Lender < ActiveRecord::Base
  has_secure_password
  has_many :histories
  has_many :lending, through: :histories, source: :borrower
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password,
            length: { minimum: 6 }
  validates :first_name,
            :last_name,
            :money,
            presence: true
end
