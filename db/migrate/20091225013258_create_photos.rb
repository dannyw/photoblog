class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :title
      t.string :img_url
      t.text :caption
      t.datetime :pub_date

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
