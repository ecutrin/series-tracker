require 'rails_helper'
require 'series_controller'

describe SeriesController do
  before(:each) do
    @controller = SeriesController.new
    @series_service = controller.load_series_service(spy "serie_service")
    @episode_service = controller.load_episodes_service(spy "episode_service")
  end

  describe "#list" do
    it "should show all the series that the user has tracked" do
      serie = Serie.new({:show_id => "123", :title => "Boo", :picture_url => "pic"})
      serie.save

      get :index

      expect(response).to render_template ("index")
      expect(assigns(:series).first).to eq(serie)
    end

    it "should show a No shows have been tracked page if no series have been tracked" do
      get :index

      expect(response).to render_template("no_series_tracked")
    end
  end

  describe "#show" do
    it "should display the show's basic info as well as the seasons' info" do
      serie = Serie.create(:show_id => "123", :title => "Boo", :picture_url => "pic", :number_of_seasons => 2)
      episode1_1 = Episode.create(:serie_id => serie.id,
				  :number => "1",
		                  :season => "1",
			          :air_date => "2015-06-06")
      episode2_1 = Episode.create(:serie_id => serie.id,
		       	          :number => "1",
		                  :season => "2",
			          :air_date => "2015-09-06")
      allow(@episode_service).to receive(:get_all_for_season).with(serie.id.to_s, 1) { [episode1_1]}
      allow(@episode_service).to receive(:get_all_for_season).with(serie.id.to_s, 2) { [episode2_1]}

      get :show, :id => serie.id

      expect(assigns(:serie)).to eq(serie)
      expect(assigns(:episodes)).to eq({"1" => [episode1_1], 
      					"2" => [episode2_1]})
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
      serie = Serie.new({:show_id => show_id, :title => title, :picture_url => picture_url})
      allow(@series_service).to receive(:get_info).with(show_id) { serie }

      post :track, :id => show_id, :title => title, :picture_url => picture_url

      expect(@series_service).to have_received(:track).with(serie)
    end
    
    it "should redirect to the search page" do
      post :track, :id => show_id

      expect(response).to redirect_to series_index_url
    end

    it "should show a successful message if it was able to start tracking the show" do
      post :track, :id => "12345"

      expect(flash.now[:success]).to be_present
    end
  end
end
