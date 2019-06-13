class BookKeepersController < ApplicationController
	before_action :authenticate_admin, only: [:show, :find_student]
	before_action :find_book_keeper, only: [:show]

	def show
	
	end

	def find_student

	end

	private

	def find_book_keeper
		@book_keeper = BookKeeper.find(params[:id])
	end

	def authenticate_admin 
		redirect_to root_path unless book_keeper_signed_in?
	end
end
