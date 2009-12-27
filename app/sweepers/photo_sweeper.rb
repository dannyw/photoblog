class PhotoSweeper < ActionController::Caching::Sweeper
  observe Photo

  # If our sweeper detects that a Photo was created call this
  def after_create(photo)
    expire_page('/index.html')
    expire_page(:controller => 'photos', :action => 'show', :id => photo.prev)
  end

  # If our sweeper detects that a Photo was updated call this
  def after_update(photo)
    expire_cache_for(photo)
  end

  # If our sweeper detects that a Photo was deleted call this
  def after_destroy(photo)
    expire_cache_for(photo)
    expire_page(:controller => 'photos', :action => 'show', :id => photo.prev)
    expire_page(:controller => 'photos', :action => 'show', :id => photo.next)
  end

  private
  def expire_cache_for(record)
    # Expire the list page now that we added a new product
    expire_page(:controller => 'photos', :action => 'show', :id => record)
  end
end