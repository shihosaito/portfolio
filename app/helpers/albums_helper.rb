module AlbumsHelper

  def album_log_in(album)
    session[:album_id] = album.id
  end

  def current_album
    @current_album ||= Album.find_by(id: session[:album_id])
  end

  def album_log_out(album)
    session.delete(:album_id)
    @current_album = nil
  end

end
