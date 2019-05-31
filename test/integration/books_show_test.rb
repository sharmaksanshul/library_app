require 'test_helper'

class BooksShowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include Devise::Test::IntegrationHelpers
  def setup
    @book_keeper = book_keepers(:anshul)
    @book = books(:one)
    @student = students(:aman)
  end

  test "should redirect show when not logged in" do
  	get book_path(@book)
  	assert_redirected_to root_path
  end

  test "should go to show page when logged in as book_keeper " do 
  	sign_in book_keepers(:anshul)
  	get book_path(@book)
  	assert_template 'books/_lib_show'
  	assert_select 'a[href=?]', issue_book_path(@book)
  	assert_select 'a[href=?]', issue_record_book_path(@book)
  	assert_select 'a[href=?]', book_path(@book)
  	assert_difference 'Book.count', -1 do
      delete book_path(@book)
    end
  end

  test "should go to show page when logged in as student " do 
  	sign_in students(:aman)
  	get book_path(@book)
  	assert_template 'books/_student_show'
  	assert_select 'a[href=?]', issue_book_path(@book), count: 0
  	assert_select 'a[href=?]', issue_record_book_path(@book), count: 0
  	assert_select 'a[href=?]', book_path(@book), count: 0
  end
end
