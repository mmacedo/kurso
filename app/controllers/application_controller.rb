class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :meti_lokaĵaro

  def url_options
    { locale: I18n.locale }.merge(super)
  end

  private

  def meti_lokaĵaro
    if params.has_key? :locale
      I18n.locale = params[:locale]
    else
      lokaĵaro =  lokaĵaro_preferita || I18n.default_locale
      redirect_to url_for(locale: lokaĵaro, only_path: true)
    end
  end

  def lokaĵaro_preferita
    http_accept_language.compatible_language_from(I18n.available_locales)
  end
end
