class ArticlesController < ApplicationController
    
    before_action :set_article, except: [:new, :create, :index, :my]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:update, :edit, :destroy]
    before_action :load_category
    
    def new 
       @article = Article.new 
        @pictures = @article.pictures.build
        @categories = Category.all
    end
    
    def load_category
        @category = Category.find(params[:category_id]) if params[:category_id]
    end
    
    def create
        @article = Article.new(article_params)
        @article.user = current_user
#        @article.category = params[:category_id]
        if @article.save
            if params[:pictures]
                params[:pictures]['picture'].each do |a|
                    @pictures = @article.pictures.create!(:picture => a)
                end
            end
            
            
            
            
            flash[:success] = "Article was successfully created"
            redirect_to article_path(@article)
        else
            render 'new'
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
            redirect_to articles_path
        end
    end
    
    def index
        
        @articles = @category ? @category.articles : Article.all
    end
    
    def my
        @articles = current_user.articles
    end
    
    
    
    
    def article_params
       params.require(:article).permit(:title, :description, :price, :category_id, pictures_attributes: [:pictures]) 
    end
    
    def set_article
       @article = Article.find(params[:id]) 
    end
    
    def require_same_user
       if @article.user != current_user and !current_user.admin?
           flash[:danger] = "You can only delete or edit your own article"
           redirect_to articles_path
       end
    end
    
end
