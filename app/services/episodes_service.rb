class EpisodesService

  def get_all_for_season(serie_id, season_number)
    episodes = []
    Episode.where(serie_id: serie_id, season: season_number).find_each do |episode|
      episodes << episode
    end
    episodes
  end

end
