class HomePage::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  layout proc { |controller| controller.request.xhr? ? false : 'application' }
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  helper_method :home_page_stylesheets, :home_page_javascripts, :resource

  before_filter :custom_view_path

  def home_page_stylesheets
    @home_page_stylesheets || ['home_page/application']
  end

  def home_page_javascripts
    @home_page_javascripts || ['home_page/application']
  end

  protected
  
  def show_breadcrumbs
    @show_breadcrumbs = true
  end

  private

  def custom_view_path
    prepend_view_path 'app/views/custom'
  end
  
  def not_found(e)
    if Rails.env.development?
      raise e
    else
      redirect_to root_path, notice: t('general.exceptions.not_found')
    end
  end
end