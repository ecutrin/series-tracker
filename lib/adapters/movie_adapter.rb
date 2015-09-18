require 'httparty'
require 'json'

class MovieAdapter
  attr_reader :endpoint_url, :key

  def initialize(endpoint_url, key)
    @endpoint_url = endpoint_url
    @key = key
  end

  def get_show_info(show_id)
    response = HTTParty.get("#{@endpoint_url}/#{show_id}?api_key=#{@key}")
  end
end
