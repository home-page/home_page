class PageModulesController < ApplicationController
  respond_to :html, :js
  
  before_filter :authenticate_user!
  
  def index
    slug_stub = if params[:slug_stub].blank?
      @page_module_slug_stubs = PageModule.pluck(:slug_stub).uniq.sort
      @page_module_slug_stubs.first
    else
      params[:slug_stub]
    end
    
    @page_modules = PageModule.where(slug_stub: slug_stub).paginate(page: params[:page], per_page: 10)
    
    if params[:slug_stub].present?
      render partial: 'page_modules/collection', layout: false
    else
      render partial: 'page_modules/tab', layout: false
    end
  end
  
  def new
    @page_module = PageModule.new(params[:page_module])
  end
  
  def create
    @page_module = PageModule.create(params[:page_module])
    
    if @page_module.persisted?
      @path = page_modules_path 
      
      if request.xhr?
        @target = '#page_modules_tab'
        @close_modal = true
      end
    else
      @template = :new
      @target = '.modal-content' if request.xhr?
    end
    
    render_or_redirect_by_request_type
  end
  
  def edit
    @page_module = PageModule.friendly.find(params[:id])
  end
  
  def update
    @page_module = PageModule.friendly.find(params[:id])
    
    if @page_module.update_attributes(params[:page_module])
      flash[:notice] = t('general.form.successfully_updated')
      
      if request.xhr?
        @template_format = 'js'
      else
        @path = edit_page_module_path(@page_module)
      end
    else
      @template = :edit
      @target = '.modal-content' if request.xhr?
    end
    
    render_or_redirect_by_request_type
  end
  
  def destroy
    @page_module = PageModule.friendly.find(params[:id]).destroy
    
    if @page_module.persisted?
      flash[:alert] = I18n.t('general.form.destroy_failed')
    else
      flash[:notice] = I18n.t('general.form.destroyed')
    end
    
    redirect_to page_modules_path unless request.xhr?
  end
  
  def resource
    @page_module
  end
end