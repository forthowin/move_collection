class Movie < ActiveRecord::Base
  validates :title, presence: true, length: { in: 1..50 }
  validates :format, presence: true, inclusion: { in: %w(VHS DVD Streaming) }
  validates :length, presence: true, inclusion: { in: 1...500 }
  validates :release_year, presence: true, inclusion: { in: 1801...2100 }
end