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
    Photo.find(params[:id]).destroy
    flash[:success] = t('photos.notices.destroyed')
    redirect_to photo_albums_path
  end

end
