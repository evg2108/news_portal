class ApplicationController < ActionController::Base

  respond_to :html, :json

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    request.env['HTTP_REFERER'] || '/'
  end

  def after_sign_in_path_for(resource)
    if !request.env['HTTP_REFERER'] || request.env['HTTP_REFERER'] == new_session_url(resource)
      '/'
    else
      request.env['HTTP_REFERER']
    end
  end
end
