class Serie < ActiveRecord::Base
  has_many :episodes

  attr_reader :title, :picture_url, :show_id

  BASE_URL = "https://image.tmdb.org/t/p/w185/"
  NOT_FOUND_IMAGE = "/assets/image_not_found.jpg" 

  def picture_url
    self[:picture_url].nil? ? NOT_FOUND_IMAGE : BASE_URL + self[:picture_url]
  end

  def self.BASE_URL
    BASE_URL
  end

  def self.NOT_FOUND_IMAGE
    NOT_FOUND_IMAGE
  end
end
