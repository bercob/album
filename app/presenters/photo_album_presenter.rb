class PhotoAlbumPresenter
  def datepicker_value(date)
    date.present? ? show_date(date) : nil
  end

  def show_date(date)
    I18n.l date
  end

  def photo_title(photo)
    "#{photo.image_file_name} <a href='#{photo.image.url}' target='_blank'><span class='glyphicon glyphicon-download-alt'></span></a>"
  end

  def photo_url(photo)
    photo.showed_photo_exist? ? photo.image.url(:showed) : photo.image.url
  end
end
