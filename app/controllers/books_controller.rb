class BooksController < ApplicationController
	before_action  :authenticate_book_keeper , only: [:new ,:create,:destroy]
	before_action :allow_admin_and_student ,only: [:index, :show]
	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		if @book.save
			redirect_to books_path
		else
			redirect_to root_path
		end	
	end

	def show
		@book = Book.find(params[:id])
		@availability = (@book.no_of_copies.to_i) - @book.count_issued_book
	end

	def issue
		@book = Book.find(params[:id])
		@issue_detail = @book.issue_details.new
	end

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

	def book_params
		params.require(:book).permit(:name, :author, :no_of_copies,:picture)
	end

	def authenticate_book_keeper
		redirect_to root_path unless book_keeper_signed_in?
	end

	def allow_admin_and_student
		redirect_to root_path unless (book_keeper_signed_in?|| student_signed_in?)
	end
end
