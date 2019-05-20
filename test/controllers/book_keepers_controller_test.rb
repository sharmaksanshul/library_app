require 'test_helper'

class BookKeepersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
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
		get allbooks_path
		assert_redirected_to root_path
	end

	test "show all books when logged as admin" do
		post new_book_keeper_session_path, params: { session: { email: @book_keeper.email,
                                          password: "123456" } } 
    # assert_redirected_to root_path
  	# assert_template 'book_keepers/show_avail_books'
    # assert book_keeper_signed_in?
    # get @book_keeper
  	 assert_response :success
     get book_keeper_path(@book_keeper)
     get availbooks_path
     assert_redirected_to root_path
     get allbooks_path 
	end
end
