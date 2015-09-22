class SeriesController < ApplicationController
  attr_reader :series_service
  before_filter :load_series_service

  def list
    @series = @series_service.find_shows(Shows.instance.get)
  end

  def search keyword
    @series = @series_service.find_by_keyword(keyword)
  end

  def load_series_service(service = SeriesService.build)
    @series_service ||= service
  end
end
