class User < ActiveRecord::Base
  ROLES = ['guest', 'user', 'staff', 'manager', 'admin']

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

  def admin?
    self[:role] == 'admin'
  end
end
