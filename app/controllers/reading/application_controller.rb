module Reading
  class ApplicationController < ActionController::Base
    include Pundit
    protect_from_forgery with: :exception

    before_action :set_locale
    layout 'application'

    def default_url_options
      { locale: I18n.locale }
    end

    protected
    def set_locale
      I18n.locale = params[:locale] || browser.accept_language.first.full
    end

    def must_admin!
      if current_user.nil? || !current_user.is_admin?
        head :forbidden
        return false
      end

      true
    end
  end
end
