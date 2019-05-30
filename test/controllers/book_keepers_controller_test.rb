require 'test_helper'

class BookKeepersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  #  def setup
  #   @request.env["devise.mapping"] = Devise.mappings[:admin]
  #   sign_in FactoryBot.create(:admin)
  # end
  def setup
    @book_keeper = book_keepers(:anshul)
  end


  test "should get signin path" do
    get new_book_keeper_session_path 
    assert_response :success
	end
	test "should get newsignup path" do
    get new_book_keeper_registration_path
    assert_response :success
	end

	test "should redirect to root path if not logged in as admin" do
		get books_path
		assert_redirected_to root_path
	end

	test "show all books and navbar option when logged as admin"  do
    sign_in book_keepers(:anshul)
	  # assert_response :success
    get books_path 
    assert_response :success
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", new_book_path
    assert_select "a[href=?]", destroy_book_keeper_session_path
    assert_select "a[href=?]", book_keeper_path(@book_keeper)
	end
end
