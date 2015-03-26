class Page < ActiveRecord::Base
  serialize :data, Hash
  
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  
  validate :valid_liquid_syntax
  
  attr_accessible :title, :content, :data
  
  extend FriendlyId
  
  friendly_id :title, use: :slugged
  
  private
  
  def valid_liquid_syntax
    Liquid::Template.parse(content)
  rescue Liquid::SyntaxError => e
    errors.add(
      :content, 
      I18n.t(
        'activerecord.errors.models.page_module.attributes.content.liquid_syntax_invalid', message: e.message
      )
    )
  end
  
  def should_generate_new_friendly_id?
    title_changed?
  end
end