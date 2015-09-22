require 'rails_helper'
require 'serie_service'

describe SerieService do
  let(:show_info_payload) { JSON.parse({:original_name => "Beauty and the Beast", :poster_path => "some_path"}.to_json) }
  let(:show_id) { "44606" }

  describe "#get_info" do
    it "should return a Serie with valid information" do
      movie_adapter = double("movie_adapter")
      service = SerieService.new(movie_adapter)
      allow(movie_adapter).to receive(:get_show_info).with(show_id) { show_info_payload }

      serie = service.get_info(show_id)

      expect(serie.title).to eq("Beauty and the Beast")
      expect(serie.picture_url).to include("some_path")
    end
  end

  describe "#find_shows" do
    it "should return a list of series with valid information" do
      movie_adapter = double("movie_adapter")
      service = SerieService.new(movie_adapter)
      show_ids = [1, 2]

      show_ids.each do |show_id|
	expect(movie_adapter).to receive(:get_show_info).with(show_id) { show_info_payload }
      end

      series = service.find_shows(show_ids)

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
end
