class CollectionsController < ApplicationController
  handles_sortable_columns

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
    @collections = Collection.joins(:movie).order(order)
  end

  def destroy
    collection = Collection.find(movie_id: params[:id])
    collection.destroy
    flash[:success] = "#{collection.movie.title} has been removed from your collection."
    redirect_to collections_path
  end
end