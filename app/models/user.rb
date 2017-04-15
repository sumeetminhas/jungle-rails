class User < ActiveRecord::Base
  has_many :reviews
  has_many :users
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def has_reviews?
    self.reviews.count > 0
  end

end
