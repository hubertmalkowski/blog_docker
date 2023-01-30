module Admin
  # documentation
  class ArticlesController < ApplicationController
    def index
      @articles = Article.all
      @user = current_user
    end

    def new
      auth_user
      @article = Article.new
    end

    def show
      @article = Article.find(params[:id])
      @user = User.find(@article.user_id)
    end

    def edit
      article = auth_article(params[:id])
      auth_user
      @article = article
    end

    def update
      @article = auth_article(params[:id])
      auth_user
      if @article.update(article_params)
        redirect_to admin_article_path(@article)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article = auth_article(params[:id])
      auth_user
      @article&.destroy
      redirect_to articles_path, status: :see_other
    end

    def create
      @article = Article.new(article_params)
      auth_user
      if @article.save
        redirect_to articles_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def article_params
      params.require(:article).permit(:title, :body).merge(user_id: current_user.id)
    end

    def auth_user
      raise Pundit::NotAuthorizedError, 'not allowed' unless UserPolicy.new(current_user).allowed?
    end

    def auth_article(id)
      article = Article.find(id)
      return article if article.user_id == current_user.id

      false
    end
  end
end
