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
    leave_review('So So', 3)
    expect(page).to have_content 'So So'
  end

  scenario 'user cannot review a restaurant twice' do
    leave_review('So So', 3)
    expect(page).not_to have_link 'Review KFC'
    click_link 'Sign out'
    sign_up_2
    expect(page).to have_link 'Review KFC'
  end

  scenario 'user should be able to delete reviews' do
    leave_review('So So', 3)
    click_link 'Delete KFC review'
    expect(page).not_to have_content 'So So'
  end

  scenario 'user cannot delete reviews that they did not create' do
    leave_review('So So', 3)
    expect(page).to have_link 'Delete KFC review'
    click_link 'Sign out'
    sign_up_2
    expect(page).not_to have_link 'Delete KFC review'
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('So So', 3)
    click_link 'Sign out'
    sign_up_2
    leave_review('Good', 4)
    expect(page).to have_content 'Average rating: 3.5'
  end


end
