require 'rails_helper'
require 'episodes_service'

describe EpisodesService do

  describe "#get_all_for_season" do
    it "should return an empty list if no episodes were found" do
      service = EpisodesService.new
      serie = Serie.create(:show_id => "123", :title => "Boo", :picture_url => "pic", :number_of_seasons => 2)

      episodes = service.get_all_for_season(serie.id, 1)

      expect(episodes).to eq([])
    end

    it "should return the list of episdes for a given show and season" do
      service = EpisodesService.new
      serie = Serie.create(:show_id => "123", :title => "Boo", :picture_url => "pic", :number_of_seasons => 2)
      episode1_1 = Episode.create(:serie_id => serie.id,
				  :number => "1",
		                  :season => "1",
			          :air_date => "2015-06-06")
      episode2_1 = Episode.create(:serie_id => serie.id,
		       	          :number => "1",
		                  :season => "2",
			          :air_date => "2015-09-06")

      episodes = service.get_all_for_season(serie.id, 2)

      expect(episodes).to eq([episode2_1])
    end
  end
end
