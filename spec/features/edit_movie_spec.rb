require 'rails_helper'

feature 'create a movie' do
  given(:movie) { Fabricate(:movie) }

  scenario 'movie is created successfully' do
    visit edit_movie_path movie
    fill_in 'Title', with: 'Jurassic World'
    select 'DVD', from: 'movie_format'
    fill_in 'Length', with: '300'
    fill_in 'Release year', with: '2015'
    find(:css, "#movie_rating_5").set true
    click_button 'Save'
    expect(page).to have_content 'The movie was updated successfully.'
    expect(page).to have_content 'DVD'
    expect(page).to have_content '300'
    expect(page).to have_content '2015'
    expect(page).to have_content '5/5'
  end

  scenario 'movie did not save due to invalid inputs' do
    visit edit_movie_path movie
    fill_in 'Title', with: ''
    select 'DVD', from: 'movie_format'
    fill_in 'Length', with: '300'
    fill_in 'Release year', with: '2015'
    click_button 'Save'
    expect(page).to have_content 'The movie was not updated due to some errors.'
  end
end