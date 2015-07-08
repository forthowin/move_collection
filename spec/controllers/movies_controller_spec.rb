require 'rails_helper'

describe MoviesController do
  describe 'GET new' do
    it 'assigns @movie as a new Movie' do
      get :new
      expect(assigns(:movie)).to be_a_new Movie
    end
  end

  describe 'POST create' do
    context 'with valid parameters' do
      before { post :create, movie: { title: 'Jurassic World', format: 'DVD', length: 300, release_year: 2015 } }
      
      it 'creates a movie' do
        expect(Movie.count).to eq 1
      end

      it 'redirects to the new template' do
        expect(response).to redirect_to new_movie_path
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid parameters' do
      before { post :create, movie: { title: 'Jurassic World' } }

      it 'does not create a movie' do
        expect(Movie.count).to eq 0
      end

      it 'renders the new template' do
        expect(response).to render_template :new
      end

      it 'sets the flash danger message' do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe 'GET index' do
    it 'assigns all the movies to @movies' do
      movie1 = Fabricate(:movie)
      movie2 = Fabricate(:movie)
      movie3 = Fabricate(:movie)
      get :index
      expect(assigns(:movies)).to eq [movie1, movie2, movie3]
    end
  end
end