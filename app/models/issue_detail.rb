class IssueDetail < ApplicationRecord
	belongs_to :student
	belongs_to :book
	validates :student_id, presence: true
	validates :issue_date, presence: true
	validates :exp_recieved_date, presence: true
	# after_validation :student_eligible, on: :create
	validate :student_eligible

	def student_eligible
		id = self.student_id
		student = Student.find(id)
		if student.issue_details.where(act_recieved_date: nil).count.to_i >= 2
			errors.add(:student_id, "should return the last issued books first")
		end
	end
end 