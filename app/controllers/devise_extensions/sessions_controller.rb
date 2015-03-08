class DeviseExtensions::SessionsController < Devise::SessionsController
  layout :layout_by_resource
  
  # GET /resource/sign_in
  def new
    @home_page_stylesheets = ['home_page/application', 'home_page/sign_in']
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end
  
  protected

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'new'
      'home_page/sign_in'
    else
      'application'
    end
  end
end