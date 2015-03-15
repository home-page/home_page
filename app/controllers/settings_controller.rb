class SettingsController < ApplicationController
  respond_to :html
  
  before_filter :authenticate_user!
  
  def index
    @settings = Setting.unscoped.index_by(&:var)
  end
  
  def show
    render json: Setting[params[:id2] || params[:id]].to_json
  end
  
  def updates
    @settings = Setting.unscoped.index_by(&:var)

    params[:setting].each do |var, value|
      next if @settings[var].nil? && (value.nil? || value.strip == '')
      
      if @settings[var] && value.strip == ''
        Setting.destroy var
      else
        Setting[var] = Setting.new(var: var, value: value).cast_value
      end
    end
    
    redirect_to settings_path, notice: t('settings.updates.done')
  end
end