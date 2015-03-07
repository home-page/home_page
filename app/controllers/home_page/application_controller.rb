class HomePage::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  layout proc { |controller| controller.request.xhr? ? false : 'application' }
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private
  
  def not_found(e)
    if Rails.env.development?
      raise e
    else
      redirect_to root_path, notice: t('general.exceptions.not_found')
    end
  end
end