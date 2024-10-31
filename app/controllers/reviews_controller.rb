class ReviewsController < ApplicationController
  before_action :authenticate_person!
  before_action :set_person

  def new
    @review = Review.new
  end

  def create
    @sitter = Person.find(params[:sitter_id])
    @review = Review.new(review_params)
    @review.reviewable = @sitter 
    @review.person = current_person

    if @review.save
      redirect_to sitter_services_path, notice: 'Review was successfully created!'
    else
      render :new, notice: 'Review could not be created'
    end
  end

  private

  def set_person
    @person = current_person
  end


  def review_params
    params.require(:review).permit(:stars, :comment)
  end
end
