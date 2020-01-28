class Rider < ApplicationRecord

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "rider_id",
                                  dependent:   :destroy

  has_one :route, dependent: :destroy
  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, 
            format: { with: VALID_EMAIL_REGEX }, 
            uniqueness: { case_sensitive: false }

  
  VALID_MOBILE_REGEX = /\A[6789]+\d{9}+\z/i
  validates :mobile, presence: true, length: { is: 10}, 
            format: { with: VALID_MOBILE_REGEX }, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def Rider.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
