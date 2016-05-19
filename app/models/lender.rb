class Lender < ActiveRecord::Base
  has_secure_password

  validates :first_name,
            :last_name,
            :email,
            :money,
            presence: true,
            length: { minimum: 6 }
end
