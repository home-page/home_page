class PagesController < ApplicationController
  respond_to :html, :js
  
  before_filter :authenticate_user!, except: [:show]
  before_filter :show_breadcrumbs
  
  def index
    @pages = Page.paginate(page: params[:page], per_page: 10)
    
    if params[:page].blank?
      @page_module_collection_slug_stubs = PageModuleCollection.pluck(:slug_stub).uniq.sort
      slug_stub = @page_module_collection_slug_stubs.first
      @page_module_collections = PageModuleCollection.where(slug_stub: slug_stub).paginate(page: params[:page], per_page: 10)
      @page_module_slug_stubs = PageModule.pluck(:slug_stub).uniq.sort 
      @page_modules = PageModule.where(slug_stub: @page_module_slug_stubs.first).paginate(page: params[:module_page], per_page: 10)
    else
      render partial: 'pages/collection', layout: false
    end
  end
  
  def new
    @page = Page.new(params[:page])
  end
  
  def create
    @page = Page.create(params[:page])
    
    if @page.persisted?
      @path = pages_path(page: 1) 
      
      if request.xhr?
        @target = '#pages_container'
        @close_modal = true
      end
    else
      @template = :new
      
      if request.xhr?
        @target = '.modal-content' 
        @target_needs_modal_layout = false
      end
    end
    
    render_or_redirect_by_request_type
  end
  
  def show
    @page = Page.friendly.find(params[:id])
  end
  
  def edit
    @page = Page.friendly.find(params[:id])
  end
  
  def update
    @page = Page.friendly.find(params[:id])
    
    if @page.update_attributes(params[:page])
      flash[:notice] = t('general.form.successfully_updated')
      
      if request.xhr?
        @template_format = 'js'
      else
        @path = edit_page_path(@page_module)
      end
    else
      @template = :edit
      @target = '.modal-content' if request.xhr?
    end
    
    render_or_redirect_by_request_type
  end
  
  def destroy
    @page = Page.friendly.find(params[:id]).destroy
    
    if @page.persisted?
      flash[:alert] = I18n.t('general.form.destroy_failed')
    else
      flash[:notice] = I18n.t('general.form.destroyed')
    end
    
    redirect_to pages_path unless request.xhr?
  end
  
  def resource
    @page
  end
  
  protected
  
  def show_breadcrumbs
    @show_breadcrumbs = true if user_signed_in?
  end
end