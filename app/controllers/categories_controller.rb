class CategoriesController < ApplicationController
    def index

        @categories = Category.all
        @category = Category.new


    end

    def new

        @category = Category.new

    end

    def create

        @category = Category.new(category_params)

        if @category.save

            flash[:success] = "Category was created successfully"

            redirect_to categories_path

        else

            render 'new'

        end

    end

    def show

    end

    def destroy
        @category = Category.find(params[:id])
        if @category.destroy
            flash[:success] = "Article was successfully deleted"
            redirect_to categories_path
        end
    end
    
    private

    def category_params

    params.require(:category).permit(:name, :image)

    end


end
