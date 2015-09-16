class SerieController < ApplicationController
  def list
      @series = Serie.all
  end
end
