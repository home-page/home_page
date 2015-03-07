class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
      
  extend FriendlyId
  
  friendly_id :name, use: :slugged    
    
  attr_accessible :name, :password, :password_confirmation, :remember_me, :first_name, :last_name, :email    
         
  before_create do |user|
    user.skip_confirmation_notification!
    user.confirmation_sent_at = nil
  end
end