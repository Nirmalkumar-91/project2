class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def show
    
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(new_update_article)
        @article.user = current_user
        if @article.save
        flash[:notice] = "Article Created sucessfuly"
        # redirect_to article_path(@article)
        redirect_to @article
        else
            render 'new'
        end
    end
    
    def edit
        
    end
    
    def update
        
        if @article.update(new_update_article)
            flash[:notice] = "Article updated sucessfully"
            redirect_to @article
        else
            render 'edit'
        end

    end

    def destroy
        @article.destroy
        redirect_to @article
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end
    def new_update_article
        params.require(:article).permit(:title, :description)
    end
    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit/delete your own article"
            redirect_to @article
        end
    end
end
