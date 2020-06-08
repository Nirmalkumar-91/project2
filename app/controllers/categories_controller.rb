class CategoriesController < ApplicationController
    before_action :require_user, only: [:new] 
    before_action :require_admin_user, only: [:create]
    def new
        @category = Category.new
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "Category sucessfully created"
            redirect_to @category
        else
            render 'new'
        end
    end

    def index
        @category = Category.paginate(page: params[:page], per_page: 5)
    end

    def show
        @category = Category.find(params[:id])
        @article_category = @category.articles.paginate(page: params[:page], per_page: 5)
        @categories = @category.articles
    end

    private

    def category_params
        params.require(:category).permit(:name)
    end

    def require_admin_user
        if !current_user.admin?
            flash[:alert] = "Only Admin can create a new Category"
            redirect_to categories_path
        end
    end
end