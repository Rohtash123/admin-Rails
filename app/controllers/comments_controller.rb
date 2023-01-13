class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    # redirect_to articles_path(@article)
    redirect_back( fallback_location: articles_path(@article))
    @account=current_account
    @comment.account_id= @account.id
    @comment.commenter= @account.first_name
    @comment.save
  end


  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: 303
  end

  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

  end

  def update
    # comment_params
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

    if params[:comment][:commenter].present?
     @comment.update!(commenter:params[:comment][:commenter])
    end
    if params[:comment][:body].present?
      @comment.update(body:params[:comment][:body])
    end
    redirect_to article_path(@article), status: 303
  end

  private
  def comment_params
    params.require(:comment).permit( :body)
  end

end
