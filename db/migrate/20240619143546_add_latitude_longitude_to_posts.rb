class AddLatitudeLongitudeToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :latitude, :float, null: false
    add_column :posts, :longitude, :float, null: false
  end
end
