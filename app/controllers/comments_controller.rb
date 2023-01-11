class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(valid_params)
    redirect_to articles_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = auth_comment(params[:id])
    if @comment
      @comment.destroy
      redirect_to articles_path(@article)
    else
      redirect_to articles_path, status: :see_other
    end
  end

  private

  def auth_comment(id)
    comment = @article.comments.find(id)
    if comment.user_id == current_user.id
      return comment
    end
    false
  end

  def valid_params
    params.require(:comment).permit(:body).merge(:user_id => current_user.id).merge(:article_id => @article.id)
  end
end
