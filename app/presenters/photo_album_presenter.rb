class PhotoAlbumPresenter
  def datepicker_value(date)
    date.present? ? show_date(date) : nil
  end

  def show_date(date)
    I18n.l date
  end
end
