class ReviewsController < ApplicationController
  before_filter :require_login

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.create(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @product
    else
      render 'products/show'
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to :back
  end

private

  def review_params
    params.require(:review).permit(:rating, :description)
  end

  def require_login
    redirect_to path_to_product unless current_user
  end

  def path_to_product
    product_path(id: params[:product_id])
  end

end