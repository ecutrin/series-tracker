class EpisodesController < ApplicationController
  def last
    serie = Serie.find(params[:series_id])
    serie.update(:last_episode_watched_id => params[:id])
    serie.save

    redirect_to series_url(params[:series_id])
  end
end
