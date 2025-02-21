class ApplicationController < ActionController::Base
  include Authentication
  allow_browser versions: :modern
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || ENV["DEFAULT_LOCALE"] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
