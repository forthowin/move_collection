module ApplicationHelper
  def format_rating(movie)
    movie.rating.nil? ? "-" : "#{movie.rating}/5"
  end

  def format_length(length)
    "#{length / 60} hr #{length % 60} m"
  end
end
