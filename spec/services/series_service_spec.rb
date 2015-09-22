require 'rails_helper'
require 'series_service'

describe SeriesService do
  let(:show_info_payload) { JSON.parse({:original_name => "Beauty and the Beast", :poster_path => "some_path"}.to_json) }
  let(:show_id) { "44606" }

  before(:each) do
    @movie_adapter = double("movie_adapter")
    @service = SeriesService.new(@movie_adapter)
  end

  describe "#get_info" do
    it "should return a Serie with valid information" do
      allow(@movie_adapter).to receive(:get_show_info).with(show_id) { show_info_payload }

      serie = @service.get_info(show_id)

      expect(serie.title).to eq("Beauty and the Beast")
      expect(serie.picture_url).to include("some_path")
    end
  end

  describe "#find_shows" do
    it "should return a list of series with valid information" do
      show_ids = [1, 2]

      show_ids.each do |show_id|
	expect(@movie_adapter).to receive(:get_show_info).with(show_id) { show_info_payload }
      end

      series = @service.find_shows(show_ids)

      expect(series.size).to eq(2)
      expect(series[0].title).to eq("Beauty and the Beast")
    end

    it "should raise an exception if no series are found" do
      pending("TODO")
      fail
    end

    it "should raise an exception if there is a problem contacting the external APi" do
      pending("TODO")
      fail
    end
  end

  describe "#find_by_keyword" do
    let(:keyword) { "diaries" }
    it "should return a list of series whose title match the keyword" do
      search_payload = JSON.parse({:total_results => "2",
				   :results => [{:original_name => "First serie",
				     		 :poster_path => "picture_1.jpg"}, 
						{:original_name => "Second serie", 
						 :poster_path => "picture_2.jpg"}]
      				  }.to_json)
      expect(@movie_adapter).to receive(:find_by_keyword).with(keyword) { search_payload }

      series = @service.find_by_keyword(keyword)

      expect(series.size).to eq(2)
      expect(series.first.title).to eq("First serie")
    end

    it "should return an empty array if no series match the criteria" do
      empty_search_payload = JSON.parse({:total_results => 0}.to_json)
      expect(@movie_adapter).to receive(:find_by_keyword).with(keyword) { empty_search_payload }

      series = @service.find_by_keyword(keyword)

      expect(series).to eq([])
    end
  end
end
