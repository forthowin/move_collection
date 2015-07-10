class CollectionsController < ApplicationController
  def create
    movie = Movie.find params[:id]
    if Collection.where(movie: movie).empty?
      Collection.create(movie: movie)
      flash[:success] = "#{movie.title} has been added to your collection."
    else
      flash[:info] = 'The movie is already in your collection.'
    end
    redirect_to collections_path
  end

  def index
    order = sortable_column_order
    @collections = Collection.order(order)
  end
end