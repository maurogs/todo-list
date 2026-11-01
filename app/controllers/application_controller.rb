class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user, :sidebar_lists

  private
    def current_user = Current.user

    def sidebar_lists
      @sidebar_lists ||= current_user.lists.includes(:tasks).to_a
    end

    def back_or_to(fallback, **options)
      redirect_back_or_to fallback, status: :see_other, **options
    end
end
