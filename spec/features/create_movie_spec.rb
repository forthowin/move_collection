require 'rails_helper'

feature 'create a movie' do
  scenario 'movie is created successfully' do
    visit new_movie_path
    fill_in 'Title', with: 'Jurassic World'
    select 'DVD', from: 'movie_format'
    fill_in 'Length', with: '300'
    fill_in 'Release year', with: '2015'
    click_button 'Save'
    expect(page).to have_content 'The movie was saved successfully.'
  end

  scenario 'movie did not save due to invalid inputs' do
    visit new_movie_path
    fill_in 'Title', with: ''
    select 'DVD', from: 'movie_format'
    fill_in 'Length', with: '300'
    fill_in 'Release year', with: '2015'
    click_button 'Save'
    expect(page).to have_content 'Movie was not saved due to some errors.'
  end
end