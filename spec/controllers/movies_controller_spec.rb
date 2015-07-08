require 'rails_helper'

describe MoviesController do
  describe 'GET new' do
    it 'assigns @movie as a new Movie' do
      get :new
      expect(assigns(:movie)).to be_a_new Movie
    end
  end
end