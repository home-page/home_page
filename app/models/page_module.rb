class PageModule < ActiveRecord::Base
  has_many :page_module_collection_modules, dependent: :destroy, foreign_key: 'module_id'
  has_many :collections, class_name: 'PageModuleCollection', through: :page_module_collection_modules
  
  scope :by_collection_slug, ->(slug) do
    PageModuleCollection.friendly.find(slug).modules.published_now.
    order('page_module_collections_modules.position ASC')
  end
  
  scope :published_now, -> do
    now = Time.now
    where(
      '(page_modules.published_from IS NULL or page_modules.published_from <= :time) AND (page_modules.published_until IS NULL or page_modules.published_until >= :time)',
      time: now
    )
  end
  
  serialize :data, Hash
  
  validates :title, presence: true, uniqueness: true
  
  validate :either_partial_path_or_content_present
  validate :valid_liquid_syntax, if: 'content.present?'
  
  attr_accessible :title, :description, :plugin, :partial_path, :content, :data, :moduleable_type, :moduleable_id, :published_from, :published_until
  
  attr_accessor :collection_id
  attr_writer :plugin
  
  extend FriendlyId
  
  friendly_id :title, use: :slugged  
  
  before_save :set_slug_stub
  
  def plugin
    return @plugin if @plugin.present?
    
    if slug_stub.present? && Setting['home_page.general.plugins'].include?("home_page_#{slug_stub}") || slug_stub == 'home'
      slug_stub      
    else
      nil
    end
  end
  
  private
  
  def either_partial_path_or_content_present
    if partial_path.blank? && content.blank?
      errors.add(
        :base,
        I18n.t(
          'activerecord.errors.models.page_module.attributes.base.either_partial_path_or_content_must_be_present'
        )
      )
    end
  end
  
  def valid_liquid_syntax
    Liquid::Template.parse(content)
  rescue Liquid::SyntaxError => e
    errors.add(
      :content, 
      I18n.t(
        'activerecord.errors.models.page_module.attributes.content.liquid_syntax_invalid',
        message: e.message
      )
    )
  end
  
  def set_slug_stub
    self.slug_stub = slug.split('-').first
  end
  
  def should_generate_new_friendly_id?
    title_changed?
  end
end