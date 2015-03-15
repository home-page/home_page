class PageModuleCollection < ActiveRecord::Base
  has_many :page_module_collection_modules, dependent: :destroy, foreign_key: 'collection_id'
  has_many :modules, class_name: 'PageModule', through: :page_module_collection_modules
  
  validates :title, presence: true
  
  attr_accessible :title
  
  extend FriendlyId
  
  friendly_id :title, use: :slugged  
  
  before_save :set_slug_stub
  
  private
  
  def set_slug_stub
    self.slug_stub = slug.split('-').first
  end
  
  def should_generate_new_friendly_id?
    title_changed?
  end
end