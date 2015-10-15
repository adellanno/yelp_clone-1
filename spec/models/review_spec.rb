require 'spec_helper'

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }
  it { is_expected.to belong_to :user }

  it 'is invalid without a restaurant' do
    review = Review.new(user_id: 1, rating: 1)
    expect(review).to have(1).error_on(:restaurant_id)
  end

  it 'is invalid without a user' do
    review = Review.new(restaurant_id: 1, rating: 1)
    expect(review).to have(1).error_on(:user_id)
  end

  it 'is invalid if the rating is more than 5' do
    review = Review.new(restaurant_id: 1, user_id: 1, rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end
