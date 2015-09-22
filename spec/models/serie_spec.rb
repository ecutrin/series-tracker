require 'rails_helper'

describe Serie do
  it "should have a valid picture url" do
    serie = Serie.new("The Simpsons", "cover.jpg")

    expect(serie.picture_url).to eq(Serie.BASE_URL + "cover.jpg")
  end

  it "should have a Not found image if picture URL was not set" do
    serie = Serie.new("The Simpsons", nil)

    expect(serie.picture_url).to eq(Serie.NOT_FOUND_IMAGE)
  end
end
