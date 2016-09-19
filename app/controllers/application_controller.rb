class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  private

  def not_authenticated
    redirect_to login_path, alert: t('sessions.alerts.login_first')
  end

  def set_locale
    I18n.locale = params['lang'] || session[:lang] || I18n.default_locale
    session[:lang] = I18n.locale
  end
end
