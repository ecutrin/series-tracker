require 'rails_helper'
require 'series_controller'
require 'shows'

describe SeriesController do
  before(:each) do
    @controller = SeriesController.new
    @series_service = controller.load_series_service(spy "serie_service")
  end

  describe "#list" do
    it "should show all the series that user is interested in" do
      @controller.list

      expect(@series_service).to have_received(:find_shows).with(Shows.instance.get)
    end
  end

  describe "#search" do
    it "should show all the series in the Movie DB that match the keyword" do
      keyword = "diaries"

      get :search, :keyword => keyword

      expect(@series_service).to have_received(:find_by_keyword).with(keyword)
    end

    it "should render a Not Found page if no shows match the criteria" do
      keyword = "diaries"
      allow(@series_service).to receive(:find_by_keyword).with(keyword) { Array.new }

      get :search, :keyword => keyword

      expect(response).to render_template ("not_found")
    end
  end

  describe "#track" do
    show_id = "12345"
    title = "Serie 1"
    picture_url = "photo.jpg"

    it "should call the service to track a specific show" do
      pending("Fix this")
      fail
      spy = spy("serie")
      serie = Serie.new({:show_id => show_id, :title => title, :picture_url => picture_url})
      post :track, :id => show_id, :title => title, :picture_url => picture_url

      expect(@series_service).to have_received(:track)
      expect(spy).to eql(serie)
    end
    
    it "should redirect to the search page" do
      post :track, :id => show_id

      expect(response).to redirect_to search_series_index_url
    end

    it "should show a successful message if it was able to start tracking the show" do
      post :track, :id => "12345"

      expect(flash.now[:success]).to be_present
    end
  end
end
