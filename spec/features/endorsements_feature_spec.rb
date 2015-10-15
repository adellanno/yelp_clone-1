require 'rails_helper'

feature 'endorsing reviews' do

  before do
    sign_up
    create_kfc
    leave_review('It was an abomination', 3)
  end

  it 'users can endorse review, which updates endorsement count', js: true do
    click_link 'Sign out'
    sign_up_2
    click_link 'Endorse review'
    expect(page).to have_content('1 endorsements')
  end

end
