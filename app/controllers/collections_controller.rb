class CollectionsController < ApplicationController
  before_action :require_user

  handles_sortable_columns

  def create
    movie = Movie.find params[:id]
    if current_user.collections.where(movie: movie).empty?
      current_user.collections.create(movie: movie)
      flash[:success] = "#{movie.title} has been added to your collection."
    else
      flash[:info] = "#{movie.title} is already in your collection."
    end
    redirect_to collections_path
  end

  def index
    order = sortable_column_order
    @collections = current_user.collections.joins(:movie).includes(:movie).order(order)
  end

  def destroy
    collection = Collection.find(params[:id])
    collection.destroy
    flash[:success] = "#{collection.movie.title} has been removed from your collection."
    redirect_to collections_path
  end

  def require_user
    unless current_user
      flash[:info] = 'You must log in to do that.'
      if request.referer
        redirect_to :back
      else
        redirect_to root_path
      end
    end
  end
end