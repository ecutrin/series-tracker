class SeriesService
  attr_reader :adapter

  def self.build
    new(MovieAdapter.build)
  end

  def initialize(movie_adapter)
    @movie_adapter = movie_adapter
  end

  def get_info(show_id)
    response = @movie_adapter.get_show_info(show_id)
    title = response["name"]
    picture_url = response["poster_path"]
    show_id = response["id"]
    number_of_seasons = response["number_of_seasons"]

    Serie.new(:title => title,
	      :picture_url => picture_url,
	      :show_id => show_id,
	      :number_of_seasons => number_of_seasons)
  end

  def find_by_keyword keyword
    response = @movie_adapter.find_by_keyword(keyword)
    total_results = response["total_results"]
    if total_results == 0
      Array.new
    else
      series = []
      response["results"].each do |show_info|
	title = show_info["name"]
	picture_url = show_info["poster_path"]
	show_id = show_info["id"] 
	series << Serie.new(:title=> title,
		   	     :picture_url => picture_url,
		   	     :show_id=> show_id)
      end
      series
    end
  end

  def track serie
    serie_id = serie[:show_id]
    serie.save

    response = @movie_adapter.get_show_info(serie_id)
    season_count = response["number_of_seasons"].to_i

    season_count.times do |season|
      episodes = get_episode_info(serie_id, season + 1)

      episodes.each do |episode|
	Episode.create(:serie_id => serie.id,
		       :number => episode["episode_number"],
		       :season => episode["season_number"],
		       :air_date => episode["air_date"],
		       :name => episode["name"])
      end
    end
  end

  private

  def get_episode_info(serie_id, season)
    response = @movie_adapter.get_season_info(serie_id, season)
    response["episodes"]
  end

end
