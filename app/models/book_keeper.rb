class BookKeeper < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable 
  validates :name, presence: true, length: {maximum: 50}
  before_save :upcasing
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    
  def upcasing
  	self.name = name.upcase
  end
end
