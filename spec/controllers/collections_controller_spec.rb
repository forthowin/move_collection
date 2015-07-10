require 'rails_helper'

describe CollectionsController do
  describe 'POST create' do
    let(:movie) { Fabricate(:movie) }

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
        Collection.create(movie: movie)
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

  describe 'GET index' do
    it 'assigns @collections' do
      movie1 = Fabricate(:movie)
      movie2 = Fabricate(:movie)
      collection1 = Fabricate(:collection, movie: movie1)
      collection2 = Fabricate(:collection, movie: movie2)
      get :index
      expect(assigns(:collections)).to eq [collection1, collection2]
    end
  end
end