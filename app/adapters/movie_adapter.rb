require 'httparty'
require 'json'

class MovieAdapter
  attr_reader :endpoint_url, :key

  def initialize(endpoint_url, key)
    @endpoint_url = endpoint_url
    @key = key
  end

  def self.build
    endpoint_url = "http://api.themoviedb.org/3/tv"
    key = "c7f5e9d263bfa5560c0ccc2906a51c60" 
    new(endpoint_url, key)
  end

  def get_show_info show_id
    response = HTTParty.get("#{@endpoint_url}/#{show_id}?api_key=#{@key}")
  end

  def find_by_keyword keyword
    response = HTTParty.get("http://api.themoviedb.org/3/search/tv?api_key=#{@key}&query=#{keyword}")
  end
end
