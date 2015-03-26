# This migration comes from home_page_engine (originally 20150325183940)
class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :slug
      t.string :title
      t.text :content
      t.text :data, limit: 16777215
      t.timestamps
    end
    
    add_index :pages, :slug, unique: true
  end
end
