require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A"' do
        restaurant = Restaurant.create(name: "Moe's Tavern")
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end
    context 'some reviews' do
      it 'returns average rating' do
        user1 = User.create(email: 'test1@example.com', password: 'example1')
        user2 = User.create(email: 'test2@example.com', password: 'example2')
        restaurant = Restaurant.create(name: 'KFC', user_id: user1.id)
        review1 = Review.create(restaurant_id: restaurant.id, user_id: user1.id, rating: 3)
        review2 = Review.create(restaurant_id: restaurant.id, user_id: user2.id, rating: 5)
        expect(restaurant.average_rating).to eq 4
      end
    end
  end
end
