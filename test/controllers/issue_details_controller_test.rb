require 'test_helper'

class IssueDetailsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include Devise::Test::IntegrationHelpers
  def setup
    @student = students(:vishnu)
  	@book_keeper = book_keepers(:anshul)
  	@book = books(:one)
  	@issue_detail = issue_details(:one)
  end

  test "should redirect to root path if book_keeper not logged in " do
  	get edit_issue_detail_path (@issue_detail)
  	assert_redirected_to root_path
  	post issue_details_path 
  	assert_redirected_to root_path
  	patch issue_detail_path(@issue_detail)
  	assert_redirected_to root_path
  end

  test "should get the edit page when logged in" do
  	sign_in book_keepers(:anshul)
  	get edit_issue_detail_path (@issue_detail)
  	assert_response :success
  	assert_template 'issue_details/edit'
  end

  test "should get create and update when logged in" do
    sign_in book_keepers(:anshul)
    post issue_details_path, params: { issue_detail: {
                                          student_id: @student.id,
                                          issue_date: Date.today,
                                          exp_recieved_date: Date.today }, 
                                          book_id: @book.id } 
    # assert_response :success
    assert_redirected_to books_path
    patch issue_detail_path(@issue_detail), params: { issue_detail: { book_id: @book.id,
                                                  student_id: @student.id,
                                                  issue_date: Date.today,
                                                  exp_recieved_date: Date.today,
                                                  act_recieved_date: Date.today,
                                                  fine: 10 }} 
    assert_redirected_to new_checkout_path(issue_detail_id: @issue_detail.id)
  end

 
end
