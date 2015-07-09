class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def create
    movie = Movie.new(movie_param)
    if movie.save
      flash[:success] = 'The movie was saved successfully.'
      redirect_to new_movie_path
    else
      flash.now[:danger] = 'Movie was not saved due to some errors.'
      render :new
    end
  end

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find params[:id]
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    if @movie.update(movie_param)
      flash[:success] = 'The movie was updated successfully.'
      redirect_to @movie
    else
      flash.now[:danger] = 'The movie was not updated due to some errors.'
      render :edit
    end
  end

  private

  def movie_param
    params.require(:movie).permit(:title, :format, :length, :release_year, :rating)
  end
end