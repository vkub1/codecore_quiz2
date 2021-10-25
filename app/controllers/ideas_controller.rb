class IdeasController < ApplicationController
    before_action :find_idea, only: [:show]

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

    private 

    def find_idea
        @idea = Idea.find params[:id]
    end
    
    def idea_params
        params.require(:idea).permit(:title, :description)
    end

end
