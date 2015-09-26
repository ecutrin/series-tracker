class AddLastEpisodeWatchedIdToSeries < ActiveRecord::Migration
  def change
    add_column :series, :last_episode_watched_id, :integer
  end
end
