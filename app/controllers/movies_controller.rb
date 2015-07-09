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

  private

  def movie_param
    params.require(:movie).permit(:title, :format, :length, :release_year, :rating)
  end
end