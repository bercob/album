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
#

class PhotosController < ApplicationController
  before_action :require_login

  def destroy
    photo = Photo.find(params[:id])
    parent_id = photo.photo_album.parent_id
    photo.destroy
    flash[:success] = t('photos.notices.destroyed')
    redirect_to "#{photo_albums_path}/#{parent_id}"
  end

end
