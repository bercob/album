class PhotoAlbumsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_photo_album, only: [:show, :destroy, :edit, :update]

  def index
    @photo_albums = PhotoAlbum.children(nil).order('created_at')
  end

  def new
    @photo_album = PhotoAlbum.new
    @photo_album.photos.build
  end

  def create
    @photo_album = PhotoAlbum.new photo_album_params
    if photos_params.present?
      photos_params[:images].each do |image|
        @photo_album.photos.new(image: image)
      end
    end

    if @photo_album.save
      flash[:success] = t('photo_albums.notices.added')
      redirect_to redirect_path @photo_album
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if photos_params.present?
      photos_params[:images].each do |image|
        @photo_album.photos.new(image: image)
      end
    end

    if @photo_album.update photo_album_params
      flash[:success] = t('photo_albums.notices.updated')
      redirect_to redirect_path @photo_album
    else
      render :edit
    end
  end

  def destroy
    destroy_children @photo_album
    flash[:success] = t('photo_albums.notices.destroyed')
    redirect_to redirect_path @photo_album
  end

  def show
    @photo_albums = PhotoAlbum.children(@photo_album.id).order('created_at')
    render :index
  end

  private

  def set_photo_album
    @photo_album = PhotoAlbum.find(params[:id])
  end

  def photo_album_params
    params.require(:photo_album).permit(:title, :parent_id)
  end

  def photos_params
    return [] if params[:photos].blank?
    params.require(:photos).permit(images: [])
  end

  def redirect_path(photo_album)
    "#{photo_albums_path}/#{photo_album.parent_id}"
  end

  def destroy_children(photo_album_id)
    PhotoAlbum.children(photo_album_id).each do |children|
      destroy_children children.id
    end
    PhotoAlbum.find(photo_album_id).destroy
  end
end
