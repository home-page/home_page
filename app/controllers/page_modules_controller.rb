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
    if params[:page_module_collection_id].present?
      @page_module_collection = PageModuleCollection.friendly.find(params[:page_module_collection_id])
      @page_module_collection_module = PageModuleCollectionModule.new(params[:page_module_collection_module])
      @page_module_collection_module.collection_id = @page_module_collection.id
      @page_modules = PageModule
      module_ids = @page_module_collection.modules.map(&:id)
      @page_modules = @page_modules.where('id NOT IN(?)', module_ids) if module_ids.any?
      @page_modules = @page_modules.order('title ASC').map{|p| [p.title, p.id]}
      
      render template: 'page_module_collections_modules/new'
    else
      @page_module = PageModule.new(params[:page_module])
    end
  end
  
  def create
    @page_module = PageModule.create(params[:page_module])
    @page_module.collection_id = params[:page_module][:collection_id]
    
    if @page_module.persisted?
      if @page_module.collection_id.present?
        @path = page_module_collections_modules_path
        @method = 'post'
        @data = { page_module_collection_module: { collection_id: @page_module.collection_id, module_id: @page_module.id } }
        @template_format = 'js'
      else
        @path = page_modules_path 
        
        if request.xhr?
          @target = '#page_modules_tab'
          @close_modal = true
        end
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
  
  def move
    page_module_collection = PageModuleCollection.friendly.find(params[:page_module_collection_id])
    page_module_collection_modules = page_module_collection.page_module_collection_modules.
    where('page_module_collections_modules.id IN(?)', params[:positions].values).index_by(&:id)
  
    params[:positions].keys.map(&:to_i).sort.each do |position|
      id = params[:positions][position.to_s]
      page_module_collection_modules[id.to_i].reload
      page_module_collection_modules[id.to_i].insert_at(position.to_i)
    end
    
    render nothing: true
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
    @page_module_collection_module || @page_module
  end
end