require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include Devise::Test::IntegrationHelpers
  def setup
  	@student = students(:aman)
  	@other_student = students(:vishnu)
  	@book = books(:one)
  end

  test "should redirect show_path if not signed in" do
  	get student_path(@student)
  	assert_redirected_to root_path
  end

  test "should redirect book_index when not logged in " do
  	get books_path
  	assert_redirected_to root_path
  end
  test "after login should get to books path" do
  	sign_in students(:aman)
  	get books_path 
  	assert_response :success
  	assert_select "a[href=?]", root_path
  	assert_select "a[href=?]", book_path(@book) 
  	assert_select "a[href=?]", destroy_student_session_path
  	assert_select "a[href=?]", student_path(@student)
  	assert_select "a[href=?]", issue_history_student_path(@student)
  end

  test "should redirect issue history when not logged in" do
  	get issue_history_student_path(@student)
  	assert_redirected_to root_path
  end

  test "should redirect student show when not logged in" do
  	get student_path(@student)
  	assert_redirected_to root_path
  	follow_redirect!
  	assert_select "a[href=?]", root_path, count: 0
  	assert_select "a[href=?]", new_book_keeper_session_path
    assert_select "a[href=?]", new_student_registration_path
  	assert_select "a[href=?]", book_path(@book), count: 0 
  	assert_select "a[href=?]", destroy_student_session_path, count: 0
  	assert_select "a[href=?]", student_path(@student), count: 0
  	assert_select "a[href=?]", issue_history_student_path(@student), count: 0
  end

  test "should get issue history when  logged in" do
  	sign_in students(:aman)
  	get issue_history_student_path(@student)
  	assert_response :success
  	assert_template 'students/issue_history' 
  end

end
