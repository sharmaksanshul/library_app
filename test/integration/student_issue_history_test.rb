require 'test_helper'

class StudentIssueHistoryTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include Devise::Test::IntegrationHelpers
  def setup
    @book_keeper = book_keepers(:anshul)
    @book = books(:one)
    @student = students(:aman)
  end

  test "should redirect issue_history when not logged in" do 
  	get issue_history_student_path(@student)
  	assert_redirected_to root_path
  end

  test "should redirect issue_history when book_keeper logged in" do
  	sign_in book_keepers(:anshul)
  	get issue_history_student_path(@student)
  	assert_redirected_to root_path
  end

  test "should get issue_history when student logged in" do
  	sign_in students(:aman)
  	get issue_history_student_path(@student)
  	assert_response :success
  	assert_template 'students/issue_history'
  	assert_select "th", "Book Id"
		assert_select "th", "IssueDate"
		assert_select "th", "Book Name"
		assert_select "th", "Status"
  end
end
