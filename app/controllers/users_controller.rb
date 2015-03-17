class UsersController < ApplicationController
  before_filter :find_resource, only: [:show, :edit, :update, :destroy]
  
  respond_to :html
  
  before_filter :authenticate_user!
  before_filter :show_breadcrumbs, except: :index
  
  def index
    @users = User.order('name ASC').paginate(page: params[:page], per_page: 10)
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if params[:user][:password].present? ? @user.update_attributes(params[:user]) : @user.update_without_password(params[:user])
      redirect_to edit_user_path(@user), notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: t('general.form.destroyed')
  end
  
  def resource
    @user
  end
  
  private
  
  def find_resource
    @user = User.friendly.find(params[:id])
  end
end
