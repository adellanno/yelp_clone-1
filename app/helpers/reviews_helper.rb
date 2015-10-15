module ReviewsHelper

  def star_rating(rating)
    return rating unless rating.is_a?(Numeric)
    rating = rating.to_i
    "★" * rating + "☆" * (5 - rating)
  end

end
