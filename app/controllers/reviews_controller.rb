class ReviewsController < ApplicationController
  
  def new
  end
  
  def create
    @product = Product.find(params[:product_id])
    review = Review.new(review_params)

     if review.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to :back, notice: 'Review deleted!'
  end

 private
    def review_params
      params.require(:review).permit(:product_id, :user_id, :description, :rating)
    end
end
