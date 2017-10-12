# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  photo_album_id     :integer
#  direct_upload_url  :string
#  processed          :boolean          default(FALSE), not null
#

class PhotosController < ApplicationController
  before_action :require_login
  before_action :set_photo_album, only: [:new, :create]

  def new
  end

  def create
    @photo = @photo_album.photos.create(photo_params)
  end

  def destroy
    photo = Photo.find(params[:id])
    photo_album = photo.photo_album
    photo.destroy
    flash[:success] = t('photos.notices.destroyed')
    redirect_to "#{photo_albums_path}/#{photo_album.id}"
  end

  private

  def photo_params
    params.require(:photo).permit(:direct_upload_url)
  end

  def set_photo_album
    @photo_album = PhotoAlbum.find(params[:photo_album_id])
  end
end
