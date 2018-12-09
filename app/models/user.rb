class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :validatable#, :confirmable

  has_many :filters
  has_many :posts

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
