require 'rails_helper'

describe Serie do
  it "should have a valid picture url" do
    serie = Serie.new(:title => "The Simpsons",
		      :picture_url => "cover.jpg",
		      :show_id => "1")

    expect(serie.picture_url).to eq(Serie.BASE_URL + "cover.jpg")
  end

  it "should have a Not found image if picture URL was not set" do
    serie = Serie.new(:title => "The Simpsons",
		      :picture_url => nil,
		      :show_id => "1")

    expect(serie.picture_url).to eq(Serie.NOT_FOUND_IMAGE)
  end
end
