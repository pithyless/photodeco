class User < ActiveRecord::Base
  ROLES = ['guest', 'user', 'staff', 'manager', 'admin']

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

  before_validation :set_role

  def set_role
    self[:role] = 'user' if self[:role].blank?
  end

  def admin?
    self[:role] == 'admin'
  end
end
