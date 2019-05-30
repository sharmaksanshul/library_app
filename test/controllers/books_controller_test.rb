require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include Devise::Test::IntegrationHelpers
  def setup
  	@student = students(:aman)
  	@other_student = students(:vishnu)
  	@book = books(:one)
  	@book_keeper = book_keepers(:anshul)
  end

  test "should redirect to root path if not logged in" do
  	post books_path
  	assert_redirected_to root_path
  	get book_path(@book)
  	assert_redirected_to root_path
  	get books_path
  	assert_redirected_to root_path
  	get issue_book_path(@book)
  	assert_redirected_to root_path
  	get issue_record_book_path(@book)
  	assert_redirected_to root_path

  end

  test "should add a book when book keeper logged in" do
  	sign_in book_keepers(:anshul)
  	post books_path, params: { book: { name: "psychology",
                                          author: "michael",
                                          no_of_copies: "2"} } 
    assert_redirected_to books_path
    # assert_template 'books'
  end

  test "should destroy book if book keeper logged in" do
    sign_in book_keepers(:anshul)
    delete book_path(@book)
    assert_redirected_to books_path
  end

  test "should get book index page if logged in as book keeper or student" do
    sign_in book_keepers(:anshul)
    get books_path
    assert_response :success
    get book_path(@book)
    assert_response :success
    sign_in students(:aman)
    get books_path
    assert_response :success
    get book_path(@book)
    assert_response :success
  end
  test "should redirect issue record when not logged in as book_keeper" do
    sign_in students(:aman)
    get issue_record_book_path(@book)
    assert_redirected_to root_path
  end

  test "should redirect issue when not logged in? or logged in as student" do
    get issue_book_path(@book)
    assert_redirected_to root_path
    sign_in students(:vishnu)
    get issue_book_path(@book)
    assert_redirected_to root_path
  end

  test "should get to issue record when logged in" do 
    sign_in book_keepers(:anshul)
    get issue_record_book_path(@book)
    assert_response :success
  end

  test "should get to issue when logged in" do
    sign_in book_keepers(:anshul)
    get issue_book_path(@book)
    assert_response :success
  end

end
