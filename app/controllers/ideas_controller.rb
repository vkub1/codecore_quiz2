class IdeasController < ApplicationController
    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new(params.require(:idea).permit(:title, :description))
        if @idea.save
            redirect_to idea_path(@idea)
        else
            render :new
        end
    end


end
