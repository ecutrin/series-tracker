class SerieController < ApplicationController
  attr_reader :serie_service
  before_filter :load_serie_service

  def list
    @series = @serie_service.find_shows(Shows.instance.get)
  end

  def load_serie_service(service = SerieService.build)
    @serie_service ||= service
  end
end
