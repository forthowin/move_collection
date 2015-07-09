module ApplicationHelper
  def format_rating(movie)
    movie.rating.nil? ? "-" : "#{movie.rating}/5"
  end
end
