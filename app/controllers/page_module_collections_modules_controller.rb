class PageModuleCollectionsModulesController < ApplicationController
  respond_to :html, :js
  
  before_filter :authenticate_user!
  
  def create
    @page_module_collection = PageModuleCollection.find(params[:page_module_collection_module][:collection_id])
    
    if params[:page_module_collection_module][:module_id].to_i == 0
      @template_namespace = 'page_modules'
      @template = 'new'
      @page_module = PageModule.new(params[:page_module])
      @page_module.collection_id = @page_module_collection.id
      @target_needs_modal_layout = false
      @target = '.modal-content'
      
      render_or_redirect_by_request_type
    else
      @page_module = PageModule.find params[:page_module_collection_module][:module_id]
      @page_module_collection.modules << @page_module
      page_module_collection_module = PageModuleCollectionModule.where(collection_id: @page_module_collection.id).order('position DESC').first
      @collection_module_id = page_module_collection_module.id
      @position = page_module_collection_module.position
      @template_format = 'js'
    end
  end
  
  def destroy
    @page_module_collection_module = PageModuleCollectionModule.find(params[:id]).destroy
    
    if @page_module_collection_module.persisted?
      flash[:alert] = I18n.t('general.form.destroy_failed')
    else
      flash[:notice] = I18n.t('general.form.destroyed')
    end
    
    redirect_to page_module_collection_path(@page_module_collection_module.collection) unless request.xhr?
  end
  
  def resource
    @page_module || @page_module_collection_module
  end
end