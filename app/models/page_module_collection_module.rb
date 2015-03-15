class PageModuleCollectionModule < ActiveRecord::Base
  self.table_name = 'page_module_collections_modules'
  
  belongs_to :collection, class_name: 'PageModuleCollection'
  belongs_to :module, class_name: 'PageModule'
end