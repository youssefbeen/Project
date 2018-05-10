class SessionsController < ApplicationController
    def new
       
    end
    
    def create
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success] = "You have successfully logged in "
            redirect_to articles_path
        else
            flash.now[:danger] = "incorrect information"
            render 'new'
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:success] = "you have logged out"
        redirect_to root_path
    end
end
