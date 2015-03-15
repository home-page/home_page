class PageModuleCollectionsController < ApplicationController
  respond_to :html, :js
  
  before_filter :authenticate_user!
  
  def index
    slug_stub = if params[:slug_stub].blank?
      @page_module_collection_slug_stubs = PageModuleCollection.pluck(:slug_stub).sort
      @page_module_collection_slug_stubs.first
    else
      params[:slug_stub]
    end
    
    @page_module_collections = PageModuleCollection.where(slug_stub: slug_stub).paginate(page: params[:page], per_page: 10)
    
    @page_module_slug_stubs = PageModule.pluck(:slug_stub).sort if params[:slug_stub].blank?
    
    render partial: 'page_module_collections/collection', layout: false if params[:slug_stub].present?
  end
  
  def new
    @page_module_collection = PageModuleCollection.new(params[:page_module_collection])
  end
  
  def create
    @page_module_collection = PageModuleCollection.create(params[:page_module_collection])
    
    if @page_module_collection.persisted?
      @path = page_module_collections_path 
      
      if request.xhr?
        @target = '#page'
        @close_modal = true
      end
    else
      @template = :new
      @target = '.modal-content' if request.xhr?
    end
    
    render_or_redirect_by_request_type
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