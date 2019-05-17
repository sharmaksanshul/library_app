class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name,presence: true
  before_save :upcase?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def upcase?
  	self.name = name.upcase
  end       
end
