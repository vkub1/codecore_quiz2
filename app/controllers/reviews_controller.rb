class ReviewsController < ApplicationController
    before_action :find_idea
    before_action :find_review, only: [:destroy]
    before_action :authenticate_user!

    def create
        @review = Review.new(review_params)
        @review.idea = @idea
        @review.user = current_user
        if @review.save
            flash[:success] = "Review created!"
            redirect_to idea_path(@idea.id)
        else
            @reviews = @idea.reviews.order(created_at: :desc)
            render '/ideas/show'
        end
    end

    def destroy
        if can?(:crud, @review) 
            if @review.destroy
                flash[:success] = "Review deleted!"
            else
                flash[:danger] = @review.errors.full_messages
            end
        redirect_to idea_path(@review.idea)
        end
    end

    private

    def find_idea
        @idea = Idea.find params[:idea_id]
    end

    def find_review
        @review = Review.find params[:id]
    end

    def review_params
        params.require(:review).permit(:body)
    end

    
end
