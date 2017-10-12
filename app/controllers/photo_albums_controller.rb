# == Schema Information
#
# Table name: photo_albums
#
#  id         :integer          not null, primary key
#  title      :string
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  taken_at   :date
#  deleted    :boolean          default(FALSE), not null
#

class PhotoAlbumsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_photo_album, only: [:show, :destroy, :edit, :update]
  before_action :set_photo_album_presenter, except: [:destroy]

  def index
    @photo_albums = PhotoAlbum.not_deleted.top_parents.ordered
  end

  def new
    @photo_album = PhotoAlbum.new
  end

  def create
    @photo_album = PhotoAlbum.new photo_album_params

    if @photo_album.save
      flash[:success] = t('photo_albums.notices.added')
      redirect_to redirect_path @photo_album.id
    else
      flash[:error] = @photo_album.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit

  end

  def update
    if @photo_album.update photo_album_params
      flash[:success] = t('photo_albums.notices.updated')
      redirect_to redirect_path @photo_album.id
    else
      flash[:error] = @photo_album.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @photo_album.update deleted: true
    PhotoAlbum.delay.clean(@photo_album.id)

    flash[:success] = t('photo_albums.notices.destroyed')
    redirect_to redirect_path @photo_album.parent_id
  end

  def show
    @photo_albums = @photo_album.children.ordered
    render :index
  end

  private

  def set_photo_album
    @photo_album = PhotoAlbum.find(params[:id])
  end

  def photo_album_params
    params.require(:photo_album).permit(:title, :parent_id, :taken_at)
  end
  
  def redirect_path(photo_album_id)
    "#{photo_albums_path}/#{photo_album_id}"
  end

  def set_photo_album_presenter
    @photo_album_presenter = PhotoAlbumPresenter.new
  end

end
