class SessionsController < ApplicationController
    def new

    end

    def create
        @user = User.find_by_email params[:email]
        if @user && @user.authenticate(params[:password])
            flash[:success] = "You have logged in succesfully"
            session[:user_id] = @user.id
            redirect_to ideas_path
        else
            flash[:alert] = "Wrong email or password!"
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to ideas_path
    end
end
