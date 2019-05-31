require 'test_helper'

class BooksIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include Devise::Test::IntegrationHelpers
  def setup
    @book_keeper = book_keepers(:anshul)
    @book = books(:one)
    @student = students(:aman)
  end

  test "should redirect index when not logged in" do
  	get books_path
  	assert_redirected_to root_path
  end

  test "should show index when logged in by book_keeper " do 
  	sign_in book_keepers(:anshul)
  	get books_path
  	assert_template 'books/_lib_index'
  	books.each do |book|
  		assert_select 'a[href=?]', book_path(book)
  	end
  end

   test "should show index when logged in by student " do 
  	sign_in students(:aman)
  	get books_path
  	assert_template 'books/_student_index'
  	books.each do |book|
  		assert_select 'a[href=?]', book_path(book)
  	end
  end

end
