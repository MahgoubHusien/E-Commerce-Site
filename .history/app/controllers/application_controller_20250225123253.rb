class ApplicationController < ActionController::Base
  include Authentication

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  around_action :switch_locale

  helper_method :current_user  # 👈 This makes current_user available in views

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
