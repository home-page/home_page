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

  def render_or_redirect_by_request_type
    if request.xhr? || request.env['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest'
      render_javascript_response
    elsif @template.present?
      render @template
    elsif @path.present?
      redirect_to @path
    end
  end
  
  def render_javascript_response
    @method ||= :get
    @data ||= {}
    @template ||= action_name unless @path.present?
    @template_format ||= 'html'
    @target ||= "#bootstrap_modal"
    @target_is_modal = @target_is_modal.nil? ? true : @target_is_modal
    @modal_title ||= I18n.t("#{controller_name}.#{action_name}.title")
    @close_modal ||= false
  
    render partial: 'shared/javascript_response.js', layout: false
  end

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