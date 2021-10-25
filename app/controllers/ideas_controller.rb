class IdeasController < ApplicationController
    before_action :find_idea, only: [:show, :destroy]

    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new(idea_params)
        if @idea.save
            redirect_to idea_path(@idea)
        else
            render :new
        end
    end

    def show

    end

    def index
        @ideas = Idea.all.order(created_at: :desc)
    end

    def destroy
        @idea.destroy
        flash[:alert] = "Idea deleted!"
        redirect_to ideas_path
    end

    private 

    def find_idea
        @idea = Idea.find params[:id]
    end
    
    def idea_params
        params.require(:idea).permit(:title, :description)
    end

end
