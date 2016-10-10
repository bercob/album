class PhotoAlbumPresenter
  def datepicker_value(date)
    date.present? ? show_date(date) : show_date(Date.today)
  end

  def show_date(date)
    # date.try(:strftime, '%d.%m.%Y')
    I18n.l date
  end
end
