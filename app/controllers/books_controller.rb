class BooksController < ApplicationController
	before_action  :authenticating_user , only: [:new ,:create,:destroy]
	before_action :allow_admin_and_student ,only: [:index]
	def new
		@book = Book.new
	end

	def create
		@book = Book.new(user_params)
		if @book.save
			redirect_to books_path
		else
			redirect_to root_path
		end	
	end
	# def show
	# end

	def index
		@books = Book.all
	end

	def destroy
		@book = Book.find(params[:id])
		if @book.destroy 
			redirect_to books_path
		else
			redirect_to root_path
		end		
	end

	private

	def user_params
		params.require(:book).permit(:name, :author, :no_of_copies,:picture)
	end

	def authenticating_user
		redirect_to root_path unless book_keeper_signed_in?
	end

	def allow_admin_and_student
		redirect_to root_path unless (book_keeper_signed_in?|| student_signed_in?)
	end
end
