class AddFreeToVideos < ActiveRecord::Migration[8.0]
  def change
    add_column :videos, :free, :boolean
  end
end
