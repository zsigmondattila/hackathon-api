class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :earned_achievements, class_name: 'EarnedAchievement'
  has_many :scoreboard, class_name: 'Scoreboard'
  has_many :vouchers, class_name: 'Voucher'
  has_many :coupons, class_name: 'Coupon'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  
  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end
end