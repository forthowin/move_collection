require 'rails_helper'

describe CollectionsController do
  describe 'POST create' do
    let(:movie) { Fabricate(:movie) }

    context 'with a signed in user' do
      let(:user) { Fabricate(:user) }
      before { session[:user_id] = user.id }

      context 'when the movie is not in the collection' do
        before { post :create, id: movie.id }

        it 'adds the movie into the collection' do
          expect(Collection.first.movie).to eq movie
        end

        it 'sets the flash success message' do
          expect(flash[:success]).to be_present
        end

        it 'redirects to the collections index page' do
          expect(response).to redirect_to collections_path
        end
      end

      context 'when the movie is already in the collection' do
        before do
          Collection.create(movie: movie, user: user)
          post :create, id: movie.id
        end

        it 'does not re-add the movie into the collection' do
          expect(Collection.count).to eq 1
        end

        it 'sets the flash info message' do
          expect(flash[:info]).to be_present
        end

        it 'redirects to the collections index page' do
          expect(response).to redirect_to collections_path
        end
      end
    end

    context 'with a user that is not signed in' do
      before { post :create, id: movie.id }

      it 'sets the flash info message' do
        expect(flash[:info]).to be_present
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET index' do
    it 'assigns @collections with a logged in user' do
      user = Fabricate(:user)
      movie1 = Fabricate(:movie)
      movie2 = Fabricate(:movie)
      collection1 = Fabricate(:collection, movie: movie1, user: user)
      collection2 = Fabricate(:collection, movie: movie2, user: user)
      session[:user_id] = user.id
      get :index
      expect(assigns(:collections)).to eq [collection1, collection2]
    end

    it 'redirects to rooth path for users that are not logged in' do
      get :index
      expect(response).to redirect_to root_path
    end
  end

  describe 'DELETE destroy' do
    let(:movie) { Fabricate(:movie) }
    let(:user) { Fabricate(:user) }
    let(:collection) { Fabricate(:collection, movie: movie, user: user) }

    context 'when the user is signed in' do
      before do
        session[:user_id] = user.id
        delete :destroy, id: collection.id
      end

      it 'removes the movie from the collection' do
        expect(Collection.count).to eq 0
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the collections index page' do
        expect(response).to redirect_to collections_path
      end
    end

    context 'when the user is not signed in' do
      before { delete :destroy, id: collection.id }

      it 'sets the flash info message' do
        expect(flash[:info]).to be_present
      end

      it 'redirects to the root_path' do
        expect(response).to redirect_to root_path
      end
    end
  end
end