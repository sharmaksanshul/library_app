require 'test_helper'

class StudentShowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include Devise::Test::IntegrationHelpers
  
  def setup
    @book_keeper = book_keepers(:anshul)
    @book = books(:one)
    @student = students(:aman)
  end

  test "should redirect show if not logged in" do  
  	get student_path(@student)
  	assert_redirected_to root_path
  end

  test "should redirect show if book_keeper logged in" do
   	sign_in book_keepers(:anshul)  
  	get student_path(@student)
  	assert_redirected_to root_path
  end

  test "should get to show page if student logged in " do
  	sign_in students(:aman)
  	get student_path(@student)
  	assert_response :success
  	assert_template 'students/show'
  end
end
