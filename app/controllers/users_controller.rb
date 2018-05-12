class UsersController < ApplicationController
    
    before_action :set_user, only: [:show, :edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.create(params_user)
        if @user.save
            flash[:success] = "Welcome to myApp #{@user.username}"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    
    def index 
        
    end
    
    def show
    end
    
    def edit
    end
    
    def update
       
        if @user.update(params_user)
            flash[:success] = "Users Updated successfully"
            redirect_to user_path(@user)
        else 
            render 'edit'
        end
    end
    
    def destroy
        
    end
    
    def check_email
        @us = User.find_by_email(params[:email])
        @bool = @us ? nil : true
        respond_to do |format|
            format.json { render json: @bool.to_json }
        end
    end


    private
    
    def params_user
        params.permit(:username, :email, :tel, :password)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def require_same_user
       if @user != current_user and !@user.admin?
           flash[:danger] = "You can only delete or edit your own article"
           redirect_to articles_path
       end
    end
    
    def require_admin

        if logged_in? and !current_user.admin?

        flash[:danger] = "Only admin users can perform that action"

        redirect_to root_path

        end

    end
        

end
