class Episode < ActiveRecord::Base
    belongs_to :serie

    attr_reader :number, :season, :air_date, :serie_id

end
