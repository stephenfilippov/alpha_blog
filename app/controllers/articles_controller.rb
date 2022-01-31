class ArticlesController < ApplicationController

    before_action :set_article, only: [:show, :edit, :update, :destroy] # runs set_article before it runs any methods that use it 
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

    def edit 
    end

    def create 
        @article = Article.new(article_params) # within () is known as white listing and setting the parameters
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article was created successfully"
            redirect_to @article # the same as writing article_path(@article) = /articles/7
        else
            render "new" #displays the form again
        end
    end

    def update 
        if @article.update(article_params)
            flash[:notice] = "Article was updated successfully"
            redirect_to @article
        else 
            render "edit"
        end
    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    private # allows use only within the controller and not outside the application

    def set_article # created method so we dont repeat ourselves DRY
        @article = Article.find(params[:id])
    end

    def article_params # created method so we dont repeat ourselves DRY
        params.require(:article).permit(:title, :description)
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can ony edit or delete your own article!"
            redirect_to @article 
        end
    end

end