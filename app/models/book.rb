class Book < ApplicationRecord
	attr_accessor :picture
	validates  :name ,presence: true
	validates  :author ,presence: true
	validates  :no_of_copies ,presence: true
	before_save   :capitalize?

	mount_uploader :picture , PictureUploader

	def capitalize?
		self.name = name.capitalize
		self.author = author.capitalize
	end
	

end
