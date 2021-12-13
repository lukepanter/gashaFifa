class AddImageToBanner < ActiveRecord::Migration[6.1]
  def change
    add_column :banners, :img_url, :string
  end
end
