require 'rails_helper'
require 'serie_service'

describe SerieService do
  let(:show_info_payload) { "{\"original_name\":\"Beauty and the Beast\",\"poster_path\":\"some_path\"}" }
  let(:show_id) { "44606" }

  describe "#get_info" do
    it "should return a Serie with valid information" do
      movieAdapter = double "MovieAdapter"
      expect(movieAdapter).to receive(:get_show_info) { show_info_payload }
      service = SerieService.new(movieAdapter)

      serie = service.get_info(show_id)

      expect(serie.title).to eq("Beauty and the Beast")
      expect(serie.picture_url).to eq("some_path")
    end
  end
end
