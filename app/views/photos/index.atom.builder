atom_feed do |feed|
  feed.title("Plasticity Photos")
  feed.updated(@photos.first.created_at)
  
  @photos.each do |photo|
    feed.entry(photo) do |entry|
      entry.title(photo.title)
      entry.content(image_tag(photo.img_url) + photo.caption, :type => 'html')
      entry.author { |author| author.name("Danny Wen") }
    end
  end
end
