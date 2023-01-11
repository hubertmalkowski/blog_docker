class ArticlesController < ApplicationController

  def index
    @articles = Article.all
    @user = current_user
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
    @user = User.find(@article.user_id)
  end

  def edit
    article = auth_article(params[:id])
    if article
      @article = article
    else
      redirect_to articles_path
    end
  end

  def update
    @article = auth_article(params[:id])
    if @article
      if @article.update(article_params)
        redirect_to @article
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @article = auth_article(params[:id])
    if @article
      @article.destroy
    end
    redirect_to articles_path, status: :see_other
  end

  def create
    puts(article_params)
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body).merge(:user_id => current_user.id)
  end

  def auth_article(id)
    article = Article.find(id)
    if article.user_id == current_user.id
      return article
    end
    false
  end

end
