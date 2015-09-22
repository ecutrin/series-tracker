require 'rails_helper'
require 'serie_controller'
require 'shows'

describe SerieController do
  describe "#list" do
    it "should show all the series that user is interested in" do
      controller = SerieController.new
      serie_service = controller.load_serie_service(spy "serie_service")

      controller.list

      expect(serie_service).to have_received(:find_shows).with(Shows.instance.get)

    end
  end
end
