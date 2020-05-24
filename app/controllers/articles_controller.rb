class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    def show
    
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(new_update_article)
        if @article.save
        flash[:notice] = "Article sucessfuly saved"
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
end