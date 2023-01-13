class LikesController < ApplicationController
  def  create
    @like = current_account.likes.new(like_params)

    if !@like.save
      flash[:notice] = @like.errors.full_messages.to_sentence
    end
    redirect_to @like
  end
  def  destroy
    @like = current_account.likes.find(params[:id])
    @article = @like
    @like.destroy
    redirect_to @like
  end
  private
  def like_params
    params.require(:like).permit(:article_id)
  end
end
