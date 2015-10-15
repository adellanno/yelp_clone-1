require 'rails_helper'
require_relative 'features_helper'

feature 'reviews' do

  before do
    sign_up
    create_kfc
  end

  scenario 'user needs to be logged in to leave a review' do
    click_link 'Sign out'
    expect(page).not_to have_link 'Review KFC'
  end

  scenario 'user can leave a review once logged in' do
    expect(page).to have_link 'Review KFC'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'So So'
    click_button 'Leave review'
    expect(page).to have_content 'So So'
  end

  scenario 'user cannot review a restaurant twice' do
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'So So'
    click_button 'Leave review'
    expect(page).not_to have_link 'Review KFC'
    click_link 'Sign out'
    sign_up_2
    expect(page).to have_link 'Review KFC'
  end



end
