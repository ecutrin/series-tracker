class Serie < ActiveRecord::Base
    has_many :episodes

    attr_reader :title, :picture_url

    def initialize(title, picture_url)
      @title = title
      @picture_url = picture_url
    end
end
