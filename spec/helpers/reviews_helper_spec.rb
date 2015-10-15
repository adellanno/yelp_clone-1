require 'rails_helper'

describe ReviewsHelper, type: :helper do

  context '#star_rating' do

    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'returns four black stars and one white star for 4.5' do
      expect(helper.star_rating(4.5)).to eq '★★★★☆'
    end

  end
end
