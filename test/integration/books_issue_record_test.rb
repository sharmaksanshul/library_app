require 'test_helper'

class BooksIssueRecordTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  include Devise::Test::IntegrationHelpers
  def setup
    @book_keeper = book_keepers(:anshul)
    @book = books(:one)
    @student = students(:aman)
  end

  test "should redirect issue_record when not logged in" do 
  	get issue_record_book_path(@book)
  	assert_redirected_to root_path
  end

  test "should redirect issue_record when wrong person logged in" do 
  	sign_in students(:aman)
  	get issue_record_book_path(@book)
  	assert_redirected_to root_path
  end

  test "should go to issue_rediect when book_keeper logged in" do
  	sign_in book_keepers(:anshul)
  	get issue_record_book_path(@book)
  	assert_response :success
  	assert_template 'books/issue_record'
  	assert_select "th", "Roll no."
    assert_select "th", "IssueDate"
    assert_select "th", "Student Name"
  end

end
 