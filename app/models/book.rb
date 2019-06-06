class Book < ApplicationRecord
	# has_many :issues, class_name: "IssueDetail"
	has_many :issue_details, dependent: :destroy
	attr_accessor :picture
	validates :name, presence: true, length: {maximum: 50}
	validates :author, presence: true, length: {maximum: 50}
	validates :no_of_copies, presence: true, length: {maximum: 2}
	validate  :picture_size
	before_save :capitalize_details
	mount_uploader :picture, PictureUploader

	def active_issues
		issue_details.where(act_recieved_date:nil)
	end

	def issue_records
		issue_details.includes(:student)
	end

	private 

	def capitalize_details
		self.name = name.capitalize
		self.author = author.capitalize
	end
  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
