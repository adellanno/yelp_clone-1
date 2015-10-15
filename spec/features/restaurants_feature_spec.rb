require 'rails_helper'
require_relative 'features_helper'

feature 'restaurants' do

  context 'when logged in' do
    scenario 'should display a prompt to add a restaurant' do
      sign_up
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before { Restaurant.create(name: 'KFC') }
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'if logged in, prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'cannot create a Restaurant if not logged in' do
      visit '/restaurants'
      expect(page).not_to have_link 'Add a restaurant'
    end

    context 'an invalid restaurant' do
      it 'does not allow you to submit a name that is too short' do
        sign_up
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_content 'kf'
        expect(page).to have_content 'Name is too short (minimum is 3 characters)'
      end
    end
  end

  context 'viewing restaurants' do

    let!(:kfc) { Restaurant.create(name: 'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end

  end

  context 'editing restaurants' do
    before do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
    end

    scenario 'lets user edit their own restaurant' do
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
    scenario 'does not let user edit another user\'s restaurant' do
      click_link 'Sign out'
      sign_up_2
      expect(page).not_to have_link 'Edit KFC'
    end

  end

  context 'deleting restaurants' do
    before do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
    end
    scenario 'lets a user delete their own restaurant' do
     click_link 'Delete KFC'
     expect(page).not_to have_content 'KFC'
     expect(page).to have_content 'Restaurant deleted successfully'
    end
    scenario 'does not let user delete another user\'s restaurant' do
      click_link 'Sign out'
      sign_up_2
      expect(page).not_to have_link 'Delete KFC'
    end
  end

end
