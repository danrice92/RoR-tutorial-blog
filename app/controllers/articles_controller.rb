class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find params[:id]
    # finds the article in the database by the ID passed in
    # Rails passes all instance variables (@article) to the view
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    # classnames begin with capital letters, so we're making a new Article
    # params[:article] pulls in the data provided by the user in the form

    if @article.save
      redirect_to @article
      # only redirects using existing instance variable if it meets params
    else
      render 'new'
      # also renders new, but with new instance variable
    end
  end

  def edit
    @article = Article.find params[:id]
  end

  def update
    @article = Article.find params[:id]

    if @article.update article_params
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      # this prevents the method from being called outside of this context
      params.require(:article).permit(:title, :text)
      # :title, :text makes sure only those two fields
      # are allowed so the form can't be misused
    end
end
