require 'test_helper'

class BooksIssueTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include Devise::Test::IntegrationHelpers
  def setup
    @book_keeper = book_keepers(:anshul)
    @book = books(:one)
    @student = students(:aman)
  end

  test "should redirect issue when not logged in" do 
  	get issue_book_path(@book)
  	assert_redirected_to root_path
  end

  test "should redirect issue when wrong person logged in" do 
  	sign_in students(:aman)
  	get issue_book_path(@book)
  	assert_redirected_to root_path
  end

  test "should get to issue when book_keeper logged in" do 
  	sign_in book_keepers(:anshul)
  	get issue_book_path(@book)
  	assert_response :success
  	assert_template 'books/issue'
  end


end
