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

  it "should be able to return the Last episode watched" do
    episode = Episode.create(:number => 1,
			     :season => 2,
			     :name => "Happy Birthday")
    serie = Serie.new(:last_episode_watched_id => episode.id)

    expect(serie.last_episode_watched).to eq("Season 2 Episode 1 - Happy Birthday")
  end

  it "should return 'None' if user has not set up the last episode watched" do
    serie = Serie.new(:last_episode_watched_id => nil)

    expect(serie.last_episode_watched).to eq("None")
  end
end
