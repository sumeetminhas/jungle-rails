class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category
  has_many :reviews

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def sold_out?
    self.quantity == 0
  end

  def review_count
    self.reviews.count
  end

  def has_reviews?
    review_count > 0
  end

  def overall_rating
    overall = 0.to_f
    self.reviews.each do |review|
      overall += review.rating
    end
    (overall / review_count).round(2)
  end


end
