class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    helper_method :current_user, :logged_in?
    before_action :set_article
    
    
    
#    def set_locale
#            I18n.default_locale = :fr
#    end
    def current_user
       @current_user ||= User.find(session[:user_id]) if session[:user_id] 
    end
    
    def logged_in?
        !!current_user
    end
    
    def require_user
        if !logged_in?
            flash[:danger] = "you must be logged in"
            redirect_to root_path
        end
    end
    
    def set_article
        @search = Article.search(params[:q])
    end
end
