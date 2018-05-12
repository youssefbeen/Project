class ArticlesController < ApplicationController
    helper_method :is_same_user
    before_action :set_article, except: [:new, :create, :index, :my]
    before_action :require_user, except: [:index, :show, :new, :create]
    before_action :require_same_user, only: [:update, :edit, :destroy]
    before_action :load_category
    
    def new 
        @article = Article.new 
        @pictures = @article.pictures.build
        @categories = Category.all
        @article.user = current_user ? current_user : User.new
        @user= @article.user
    end
    
    def load_category
        @category = Category.find(params[:category_id]) if params[:category_id]
    end
    
    def create
          
#        @pics = [params[:picture_0], params[:picture_1]]
        
        @article = Article.new(article_params)
        @article.user = current_user if current_user 
        @user= @article.user
        session[:user_id] = @user.id

#        @article.pictures.new(@pics[0])
#        @article.pictures.new(@pics[1])
#        @user = logged_in? ? current_use
#        r : User.new
#        @article.user = @user
#        @article.category = params[:category_id]
        
    respond_to do |format|

        if @article.save
#            if params[:pictures]
#                params[:pictures]['picture'].each do |a|
#                    @pictures = @article.pictures.create!(:picture => a)
#                end
#            end
            
            
            flash[:success] = "Article was successfully created"
            format.html{redirect_to article_path(@article)}
        else
            format.html{render action: "new" }
        end
    end
    end
    
    def show
        @pictures = @article.pictures.all
    end
    
    def edit
    end
    
    def update
        if @article.update(article_params)
            flash[:success] = "Article was successfully updated"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end
    
    def destroy
        if @article.destroy
            flash[:success] = "Article was successfully deleted"
#            redirect_to articles_path
            redirect_back fallback_location: root_path
        end
    end
    
    

    def index
        @search = Article.search(params[:q])
        @articles = @search.result
#        @articles = @category ? @category.articles : Article.all
    end
    
    def my
        @articles = current_user.articles
    end
    
    def is_same_user(article)
        current_user ? current_user==article.user : false
    end 
    
    
    
    def article_params
       params.require(:article).permit(:title, :description, :price, :category_id, :city_id, pictures_attributes: [:picture, :picture_cache,:_destroy], user_attributes: [:username, :tel, :email, :password]) 
    end
    
    def set_article
       @search = Article.search(params[:q])
       @article = Article.find(params[:id])
       @user = @article.user
    end
    
    def require_same_user
       if @article.user != current_user and !current_user.admin?
           flash[:danger] = "You can only delete or edit your own article"
           redirect_to articles_path
       end
    end
    
end
