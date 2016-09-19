# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class PhotosController < ApplicationController
  before_action :require_login, except: [:index]

  def index
    @photos = Photo.order('created_at')
  end

  def new
    @photo = Photo.new
  end

  def create
    success = true
    permitted_photo_params = photo_params
    if permitted_photo_params[:images].present?
      permitted_photo_params[:images].each do |image|
        @photo = Photo.new(title: permitted_photo_params[:title], image: image)
        unless @photo.valid?
          success = false
          break
        end
      end
    else
      @photo = Photo.new(title: permitted_photo_params[:title])
      @photo.valid?
      success = false
    end

    if success
      permitted_photo_params[:images].each do |image|
        @photo = Photo.new(title: permitted_photo_params[:title], image: image)
        @photo.save
      end
      flash[:success] = t('photos.notices.added')
      redirect_to photos_path
    else
      render 'new'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:success] = t('photos.notices.destroyed')
    redirect_to photos_path
  end

  private

  def photo_params
    params.require(:photo).permit(:title, images: [])
  end

end
