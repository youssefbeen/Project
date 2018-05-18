class SessionsController < ApplicationController
    def new

    end

    def create
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success] = "Connexion reussie"
            redirect_to articles_path
        else
            flash.now[:danger] = "Veuillez rentrez des informations valides"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "Vous etes deconnectes"
        redirect_to root_path
    end
end
