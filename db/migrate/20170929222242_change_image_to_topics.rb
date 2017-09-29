class ChangeImageToTopics < ActiveRecord::Migration
  def change
    change_column :topics, :image, :string
  end
end
