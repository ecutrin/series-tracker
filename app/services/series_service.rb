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
    title = response["original_name"]
    picture_url = response["poster_path"]

    Serie.new(title, picture_url)
  end

  def find_shows(show_ids)
    series = []
    show_ids.each do |show_id|
      series << get_info(show_id)
    end
    series
  end

  def find_by_keyword keyword
  end

end
