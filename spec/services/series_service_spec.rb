require 'rails_helper'
require 'series_service'

describe SeriesService do
  let(:show_info_payload) { JSON.parse({:id => "3456",
    					:name => "Beauty and the Beast", 
				        :poster_path => "some_path",
 					:number_of_seasons => "2"}.to_json)
 					}
  let(:show_id) { "44606" }

  before(:each) do
    @movie_adapter = double("movie_adapter")
    @service = SeriesService.new(@movie_adapter)
  end

  describe "#get_info" do
    it "should return a Serie with valid information" do
      allow(@movie_adapter).to receive(:get_show_info).with(show_id) { show_info_payload }

      serie = @service.get_info(show_id)

      expect(serie[:title]).to eq("Beauty and the Beast")
      expect(serie[:picture_url]).to include("some_path")
      expect(serie[:show_id]).to eq("3456")
      expect(serie[:number_of_seasons]).to eq(2)
    end
  end

  describe "#find_by_keyword" do
    let(:keyword) { "diaries" }
    it "should return a list of series whose title match the keyword" do
      search_payload = JSON.parse({:total_results => "2",
				   :results => [{:name => "First serie",
				     		 :poster_path => "picture_1.jpg"}, 
						{:name => "Second serie", 
						 :poster_path => "picture_2.jpg"}]
      				  }.to_json)
      expect(@movie_adapter).to receive(:find_by_keyword).with(keyword) { search_payload }

      series = @service.find_by_keyword(keyword)

      expect(series.size).to eq(2)
      expect(series.first[:title]).to eq("First serie")
    end

    it "should return an empty array if no series match the criteria" do
      empty_search_payload = JSON.parse({:total_results => 0}.to_json)
      expect(@movie_adapter).to receive(:find_by_keyword).with(keyword) { empty_search_payload }

      series = @service.find_by_keyword(keyword)

      expect(series).to eq([])
    end

    it "should handle if response is nil (invalid)" do
      pending("TODO")
      fail
    end
  end

  describe "#track" do

    serie = Serie.new(:show_id => "12345",
		      :title => "Brand new serie",
		      :picture_url => "some_pic.jpg")
    before(:each) do
      show_id = serie[:show_id]
      season_1_info = JSON.parse({:episodes => [{:episode_number => "1",
      						 :season_nunmber => "1",
      						 :air_date => "2012-10-11",
      						 :name => "Who Am I?"},
     						{:episode_number => "2",
      						 :season_nunmber => "1",
      						 :air_date => "2012-10-18",
      						 :name => "Sunshine"}]
      				 }.to_json)
      season_2_info = JSON.parse({:episodes => [{:episode_number => "1",
      						 :season_nunmber => "2",
      						 :air_date => "2013-10-07",
      						 :name => "Birthday"}]
      				 }.to_json)

      allow(@movie_adapter).to receive(:get_show_info).with(show_id) { show_info_payload }
      expect(@movie_adapter).to receive(:get_season_info).with(show_id, 1) { season_1_info }
      expect(@movie_adapter).to receive(:get_season_info).with(show_id, 2) {season_2_info }
    end

    it "should return a valid response if it's able to start tracking the serie" do
      initial_count_of_series = Serie.count

      @service.track(serie)

      expect(Serie.count).to eq(initial_count_of_series + 1)
    end

    it "should save all episode information for the serie" do
      @service.track(serie)

      actual_episodes = Episode.where(serie_id: serie.id)
      expect(actual_episodes.size).to eq(3)
      expect(actual_episodes.first[:name]).to eq("Who Am I?")
    end

    it "should return an error code if there's a problem tracking the serie" do
      pending("TODO")
      fail
    end
  end
end
