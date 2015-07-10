class Movie < ActiveRecord::Base
  validates :title, presence: true, length: { in: 1..50 }
  validates :format, presence: true, inclusion: { in: %w(VHS DVD Streaming) }
  validates :length, presence: true, inclusion: { in: 1..500, message: 'must be between 1-500' }
  validates :release_year, presence: true, inclusion: { in: 1800..2100, message: 'must be between 1800-2100' }

  has_many :collections, dependent: :destroy

  before_save :check_cover

  mount_uploader :cover, CoverUploader

  private

  def check_cover
    if self.cover.url.nil?
      self.cover =  File.open("#{Rails.root}/public/nocover.jpg")
    end
  end
end