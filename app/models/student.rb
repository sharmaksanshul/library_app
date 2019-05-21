class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # has_many :issues, class_name: "IssueDetail"
  has_many :issue_details
  validates :name, presence: true, length: {maximum: 50}
  before_save :upcasing
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def upcasing
  	self.name = name.upcase
  end       
end
