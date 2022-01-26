class ArticlesController < ApplicationController
    def show 
        @article = Article.find(params[:id])
    end

    def index 
        @articles = Article.all
    end

    def new 
        @article = Article.new
    end

    def create 
        @article = Article.new(params.require(:article).permit(:title, :description))
        if @article.save

            redirect_to @article # the same as writing article_path(@article) = /articles/7
        else
            render "new" #displays the form again
        end
    end

end