require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include Devise::Test::IntegrationHelpers
  def setup
  	@student = students(:aman)
  	@book_keeper = book_keepers(:anshul)
  end

  test "should redirect to root_path if not logged in" do
  	get books_path
  	assert_redirected_to root_path
  end

  test "should get to books_path if logged book keeper in" do
  	sign_in book_keepers(:anshul)
  	get books_path
  	assert_response :success
  end

  test "should get to books_path if logged in" do
  	sign_in students(:aman)
  	get books_path
  	assert_response :success
  end


end
