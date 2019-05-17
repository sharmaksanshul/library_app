class Book < ApplicationRecord
	attr_accessor :picture

	mount_uploader :picture , PictureUploader
	

end
