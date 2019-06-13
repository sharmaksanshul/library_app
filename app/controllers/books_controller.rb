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
			flash[:success] = "Book saved successfully"
			redirect_to books_path
		else
			render 'new'
		end	
	end

	def show
		@availability = (@book.no_of_copies) - (@book.active_issues).count
		@active_issue_details = @book.active_issues
	end

	def issue
		@issue_detail = @book.issue_details.new
	end
	
	def issue_record
		@issue_record = @book.issue_records	
	end

	def index
		@books = Book.paginate(page: params[:page], per_page: 8)
		if params[:search]
   		@books = Book.where(["name LIKE ?","%#{params[:search]}%"]).paginate(page: params[:page], per_page: 8)
    end
	end

	def destroy
		if @book.destroy 
			flash[:danger] = "Book deleted successfully"
			redirect_to books_path
		else
			redirect_to @book
		end		
	end

	private

	def book_params
		params.require(:book).permit(:name, :author, :no_of_copies, :picture)
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
