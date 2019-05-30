require 'test_helper'

class BookKeeperTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@book_keeper = book_keepers(:anshul)
  end

  test "should be valid " do 
  	assert @book_keeper.valid?
  end

  test "name should be valid" do
  	@book_keeper.name = "mamsadcdlacnad"
  	assert @book_keeper.valid?
  end

  test "name not valid" do 
  	@book_keeper.name = "mamsadcdlacnad"*10
  	assert_not @book_keeper.valid?
  	@book_keeper.name = ""
  	assert_not @book_keeper.valid?
  	@book_keeper.name = "  "*10
  	assert_not @book_keeper.valid?
  	@book_keeper.name = "a"*51
  	assert_not @book_keeper.valid?
  end

  test "email not valid " do
  	@book_keeper.email = "avdcdd"*10
  	assert_not @book_keeper.valid?
  	@book_keeper.email = ""
  	assert_not @book_keeper.valid?
  	@book_keeper.email = "   "
  	assert_not @book_keeper.valid?
	end

	test "email address should be unique" do
		@dup_book_keeper = @book_keeper.dup
		@dup_book_keeper.save
  	assert_not @dup_book_keeper.valid?
  	@dup_book_keeper = @book_keeper.dup
  	@dup_book_keeper.email = @book_keeper.email.upcase
  	@dup_book_keeper.save
  	assert_not @dup_book_keeper.valid?
	end

	test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @book_keeper.email = mixed_case_email
    @book_keeper.save
    assert_equal mixed_case_email.downcase, @book_keeper.reload.email
    assert_not_equal mixed_case_email, @book_keeper.reload.email
  end
end
