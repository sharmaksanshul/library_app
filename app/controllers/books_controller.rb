class BooksController < ApplicationController
	before_action :authenticate_book_keeper, only: [:new, :create, :destroy,
	  :issue, :issue_record]
	before_action :current_user, only: [:index, :show]
	before_action :find_book, only: [:show, :issue, :issue_record, :destroy]
	
	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		if @book.save
			redirect_to books_path
		else
			redirect_to new_book_path
		end	
	end

	def show
		# debugger
		# @book = Book.find(params[:id])
		@availability = (@book.no_of_copies.to_i) - (@book.active_issues).count
		@active_issue_details = @book.active_issues
	end

	def issue
		# @book = Book.find(params[:id])
		@issue_detail = @book.issue_details.new
	end
	
	def issue_record
		# @book = Book.find(params[:id])
		@issue_record = @book.issue_records	
	end

	def index
		if @books = Book.where(["name LIKE ?","%#{params[:search]}%"])
    else
      @books = Book.all
    end
	end

	def destroy
		# @book = Book.find(params[:id])
		if @book.destroy 
			redirect_to books_path
		else
			redirect_to @book
		end		
	end

	private

	def book_params
		params.require(:book).permit(:name, :author, :no_of_copies,:picture)
	end

	def authenticate_book_keeper
		redirect_to root_path unless book_keeper_signed_in?
	end

	def current_user
		redirect_to root_path unless (book_keeper_signed_in?|| student_signed_in?)
	end

	def find_book
		@book = Book.find(params[:id])
	end
end
