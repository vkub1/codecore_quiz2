class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        idea = Idea.find params[:idea_id]
        like = Like.new(idea: idea, user: current_user)
        if can?(:like, idea)
            if like.save
                flash[:success] = "Idea Liked"
            else
                flash[:alert] = like.errors.full_messages.join(', ')
            end
        else
            flash[:alert] = "You can't like your own idea"
        end
        redirect_to ideas_path
    end

    def destroy
        @like = Like.find params[:id]
        if can?(:destroy, @like)
            if @like.destroy
                flash[:success] ="Idea Unliked!"
            else
                flash[:alert] = like.errors.full_messages.join(', ')  
            end
        else
            flash[:alert] = "You cant unlike someone else's like"
        end
        redirect_to ideas_path
    end
end
