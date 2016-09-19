class AdminController < ApplicationController
  before_action :require_login, except: [:index]

  def index
    redirect_to login_path
  end

  def upload
  end

  def album
  end

end
