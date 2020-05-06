class ArticlesController < ApplicationController
    def new
        @article = Article.new
    end
end

def create
    @article = article.new(article_params)
    if article.save
        flash[:notice] = "Article créé"
        redirect_to article_path(@article)
    else
        render 'new'
    end
end


private

def article_params
    params.require(:article).permit(:title, :description)
end