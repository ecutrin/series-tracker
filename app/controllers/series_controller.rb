class SeriesController < ApplicationController
  attr_reader :series_service
  before_filter :load_series_service

  def index
    @series = Serie.all
    if @series.empty?
      render "no_series_tracked"
    end
  end

  def search
    @series = @series_service.find_by_keyword(params[:keyword])
    if @series.empty?
      render "not_found"
    end
  end

  def track
    serie = @series_service.get_info(params[:id])
    @series_service.track(serie)
    flash.now[:success] = "Show tracked"
    redirect_to series_index_url
  end

  def load_series_service(service = SeriesService.build)
    @series_service ||= service
  end
end
