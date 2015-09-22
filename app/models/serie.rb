class Serie < ActiveRecord::Base
    has_many :episodes

    BASE_URL = "https://image.tmdb.org/t/p/w185/"
    attr_reader :title, :picture_url

    def initialize(title, picture_url)
      @title = title
      @picture_url = BASE_URL + picture_url
    end

    def self.BASE_URL
      BASE_URL
    end
end
