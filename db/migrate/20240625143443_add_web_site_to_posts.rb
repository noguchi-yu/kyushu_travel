class AddWebSiteToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :web_site, :string
  end
end
