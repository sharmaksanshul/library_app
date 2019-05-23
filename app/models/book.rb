class Book < ApplicationRecord
	# has_many :issues, class_name: "IssueDetail"
	has_many :issue_details
	attr_accessor :picture
	validates :name, presence: true, length: {maximum: 50}
	validates :author, presence: true, length: {maximum: 50}
	validates :no_of_copies, presence: true
	before_save :capitalize_details
	mount_uploader :picture , PictureUploader

	def count_issued_book
		issue_details.where(act_recieved_date:nil).count
	end

	private 

	def capitalize_details
		self.name = name.capitalize
		self.author = author.capitalize
	end
end
