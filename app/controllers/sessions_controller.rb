class SessionsController < ApplicationController

    def new

    end

    def create
        @user = User.find_by_email params[:email]
        if @user && @user.authenticate(params[:password])
            flash[:success] = "You have logged in succesfully"
            redirect_to ideas_path
        else
            flash[:alert] = "Wrong email or password!"
            render :new
        end
    end
    
end
