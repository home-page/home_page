class PageModuleCollectionsController < ApplicationController
  respond_to :html, :js
  
  before_filter :authenticate_user!
  before_filter :show_breadcrumbs, except: :index
  
  def index
    redirect_to pages_path if params[:slug_stub].blank?
    
    @page_module_collections = PageModuleCollection.where(slug_stub: params[:slug_stub]).paginate(page: params[:page], per_page: 10)
    
    render partial: 'page_module_collections/collection', layout: false
  end
  
  def new
    @page_module_collection = PageModuleCollection.new(params[:page_module_collection])
  end
  
  def create
    @page_module_collection = PageModuleCollection.create(params[:page_module_collection])
    
    if @page_module_collection.persisted?
      @path = page_module_collections_path(slug_stub: @page_module_collection.slug_stub) 
      
      if request.xhr?
        @target = "#page_module_collections_slug_stub_#{@page_module_collection.slug_stub}"
        @close_modal = true
      end
    else
      @template = :new
      @target = '.modal-content' if request.xhr?
    end
    
    @target_needs_modal_layout = false if request.xhr?
    
    render_or_redirect_by_request_type
  end
  
  def show
    @page_module_collection = PageModuleCollection.friendly.find(params[:id])
    @page_modules = @page_module_collection.modules.select(
      'page_modules.*, page_module_collections_modules.id AS collection_module_id, page_module_collections_modules.position'
    ).order('page_module_collections_modules.position ASC')
  end
  
  def edit
    @page_module_collection = PageModuleCollection.friendly.find(params[:id])
  end
  
  def update
    @page_module_collection = PageModuleCollection.friendly.find(params[:id])
    
    if @page_module_collection.update_attributes(params[:page_module_collection])
      flash[:notice] = t('general.form.successfully_updated')
      
      if request.xhr?
        @template_format = 'js'
      else
        @path = edit_page_module_collection_path(@page_module_collection)
      end
    else
      @template = :edit
      @target = '.modal-content' if request.xhr?
    end
    
    @target_needs_modal_layout = false if request.xhr?
    
    render_or_redirect_by_request_type
  end
  
  def destroy
    @page_module_collection = PageModuleCollection.friendly.find(params[:id]).destroy
    
    if @page_module_collection.persisted?
      flash[:alert] = I18n.t('general.form.destroy_failed')
    else
      flash[:notice] = I18n.t('general.form.destroyed')
    end
    
    redirect_to page_module_collections_path unless request.xhr?
  end
  
  def resource
    @page_module_collection
  end
end