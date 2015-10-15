module ReviewsHelper

  def star_rating(rating)
    return rating unless rating.is_a?(Numeric)
    rating = rating.round
    "★" * rating + "☆" * (5 - rating)
  end

end
