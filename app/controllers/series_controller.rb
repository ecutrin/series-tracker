class SeriesController < ApplicationController
  attr_reader :series_service
  before_filter :load_series_service

  def list
    @series = @series_service.find_shows(Shows.instance.get)
  end

  def search
    @series = @series_service.find_by_keyword(params[:keyword])
    if @series.empty?
      render "not_found"
    end
  end

  def load_series_service(service = SeriesService.build)
    @series_service ||= service
  end
end
