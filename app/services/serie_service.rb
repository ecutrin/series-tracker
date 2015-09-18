class SerieService
  attr_reader :adapter

  def initialize(adapter)
    @adapter = adapter
  end

  def get_info(show_id)
    response = adapter.get_show_info(show_id)
    json_response = JSON.parse(response)
    title = json_response["original_name"]
    picture_url = json_response["poster_path"]

    Serie.new(title, picture_url)
  end
end
