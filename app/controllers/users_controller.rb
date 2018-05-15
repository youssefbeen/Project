class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:index, :destroy]

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
      @users = User.all.order(created_at: :desc)
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
      if @user.destroy
          flash[:success] = "Article was successfully deleted"
#            redirect_to articles_path
          redirect_back fallback_location: root_path
      end
    end

    def check_email
        @us = User.find_by_email(params[:email]) if params[:email]
        @us = User.find_by_email(params["article"]["user_attributes"][:email]) if params["article"]
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
       if !@user==current_user and !current_user.admin?
           flash[:danger] = "You can only delete or edit your own profile"
           redirect_to users_path
       end
    end

    def require_admin

        if current_user and !current_user.admin?

          flash[:danger] = "Only admin users can perform that action"

          redirect_to root_path
        elsif !current_user
          require_user

        end

    end


end
