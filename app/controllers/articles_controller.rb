class ArticlesController < ApplicationController
  before_action :authenticate_account!
  before_action :acc

  def index
    if current_account.roles.first.name=="admin"
      @articles = Article.all
    else
      @articles = Article.where(status: :public).or(Article.where(account: current_account)).order("created_at DESC")
    end
  end

  def show
    @article = Article.find(params[:id])

  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params_home)
    @article.account_id = current_account.id
    # title name change  to first name
    @article.title=current_account.first_name
    if @article.save
      redirect_to articles_path
    else
      redirect_to root_url
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end


  private
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
  def article_params_home
    params.permit(:title, :body,:status)
  end
  def acc
    @accounts=Account.all
  end
end
