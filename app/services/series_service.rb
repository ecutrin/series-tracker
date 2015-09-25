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
    show_id = response["id"]

    Serie.new(:title => title,
	      :picture_url => picture_url,
	      :show_id => show_id)
  end

  def find_shows(show_ids)
    series = []
    show_ids.each do |show_id|
      series << get_info(show_id)
    end
    series
  end

  def find_by_keyword keyword
    response = @movie_adapter.find_by_keyword(keyword)
    total_results = response["total_results"]
    if total_results == 0
      Array.new
    else
      series = []
      response["results"].each do |show_info|
	title = show_info["original_name"]
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
    
  end

end
