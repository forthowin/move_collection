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

  describe 'GET show' do
    it 'assigns @movie' do
      movie = Fabricate(:movie)
      get :show, id: movie.id
      expect(assigns(:movie)).to eq movie
    end
  end

  describe 'GET edit' do
    it 'assigns @movie' do
      movie = Fabricate(:movie)
      get :edit, id: movie.id
      expect(assigns(:movie)).to eq movie
    end
  end

  describe 'POST update' do
    let(:movie) { Fabricate(:movie) }

    context 'with valid parameters' do
      before { patch :update, id: movie.id, movie: { title: 'Jurassic World', rating: 3 } }
      
      it 'updates the movie' do
        expect(Movie.first.title).to eq 'Jurassic World'
        expect(Movie.first.rating).to eq 3
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the movie show page' do
        expect(response).to redirect_to movie_path movie
      end
    end

    context 'with invalid parameters' do
      before { patch :update, id: movie.id, movie: { title: 'Jurassic World', length: 600 } }

      it 'does not update the movie' do
        expect(Movie.first.title).not_to eq 'Jurassic World'
      end

      it 'assigns @movie' do
        expect(assigns(:movie)).to eq movie
      end

      it 'sets the flash danger message' do
        expect(flash[:danger]).to be_present
      end

      it 'renders the edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before { delete :destroy, id: Fabricate(:movie).id }

    it 'destroys the movie' do
      expect(Movie.count).to eq 0
    end

    it 'redirects to the index page' do
      expect(response).to redirect_to movies_path
    end

    it 'sets the flash success message' do
      expect(flash[:success]).to be_present
    end
  end
end