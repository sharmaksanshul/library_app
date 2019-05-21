class BookKeeper < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable 
  validates :name, presence: true, length: {maximum: 50}
  before_save :upcasing
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # def BookKeeper.digest(string)
  # 	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                                               BCrypt::Engine.cost
  # 	BCrypt::Password.create(string, cost: cost)
  # end      

  def upcasing
  	self.name = name.upcase
  end
end
