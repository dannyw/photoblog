class Photo < ActiveRecord::Base
  validates_presence_of :title, :img_url, :caption
end
