class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    unless @user.valid?
      render new_session_path
      return
    end

    if login params[:user][:email], params[:user][:password]
      redirect_to upload_admin_index_path, notice: t('sessions.notices.login_ok')
    else
      render new_session_path, alert: t('sessions.alerts.authenticate_failed')
    end

  end

  def destroy
    logout
    redirect_to login_path, notice: t('sessions.notices.logout_ok')
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
