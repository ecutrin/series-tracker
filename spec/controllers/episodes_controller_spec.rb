require 'rails_helper'
require 'episodes_controller'

describe EpisodesController do
  describe "#last" do

    it "should set the last episode watched" do
      serie = Serie.create

      post :last, :series_id => serie.id, :id => "5"

      updated_serie = Serie.find(serie.id)
      expect(updated_serie[:last_episode_watched_id]).to eq(5)
    end

    it "should redirect to the show view" do
      serie = Serie.create

      post :last, :series_id => serie.id, :id => "5"

      expect(response).to redirect_to(series_url(serie.id))

    end
  end
end
