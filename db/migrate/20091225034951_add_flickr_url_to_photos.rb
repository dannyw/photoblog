class AddFlickrUrlToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :flickr_url, :string
  end

  def self.down
    remove_column :photos, :flickr_url
  end
end
