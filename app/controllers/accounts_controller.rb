class AccountsController < ApplicationController

  def index
    @accounts = Account.order(created_at: :asc)
  end
  def edit
    @article = Article.find(params[:id])
  end
  def show

  end

end
