class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    helper_method :current_user, :logged_in?, :is_admin?
    before_action :set_article
    
#    unless config.consider_all_requests_local
#        rescue_from Exception, :with => :render_error
#        rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
#        rescue_from ActionController::RoutingError, :with => :render_not_found
#        rescue_from ActionController::UnknownController, :with => :render_not_found
#        # customize these as much as you want, ie, different for every error or all the same
#        rescue_from ActionController::UnknownAction, :with => :render_not_found
#      end
#  
#  private
#  
#  def render_not_found(exception)
#    render :template => "/public/404.html.erb", :status => 404
#  end
#  
#  def render_error(exception)
#    # you can insert logic in here too to log errors
#    # or get more error info and use different templates
#    render :template => "/public/500.html.erb", :status => 500
#  end
    
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
    
    def is_admin?
        current_user ? current_user.admin? : false
    end
end
