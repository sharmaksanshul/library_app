require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@book = books(:one)
    @obook = books(:two)
  end

  test "should be valid " do 
  	assert @book.valid?
  end

	test "name should be valid" do
  	@book.name = "mamsadcdlacnad"
  	assert @book.valid?
  end

  test "name not valid" do 
  	@book.name = "mamsadcdlacnad"*10
  	assert_not @book.valid?
  	@book.name = ""
  	assert_not @book.valid?
  	@book.name = "  "*10
  	assert_not @book.valid?
  	@book.name = "a"*51
  	assert_not @book.valid?
  end

  test "author not valid" do 
  	@book.author = "mamsadcdlacnad"*10
  	assert_not @book.valid?
  	@book.author = ""
  	assert_not @book.valid?
  	@book.author = "  "*10
  	assert_not @book.valid?
  	@book.author = "a"*51
  	assert_not @book.valid?
  end

  test "no_of_copies not valid" do 
  	@book.no_of_copies = 11*10
  	assert_not @book.valid?
  	@book.no_of_copies = 111
  	assert_not @book.valid?
  	@book.no_of_copies = 
  	assert_not @book.valid?
  	@book.no_of_copies = 22*51
  	assert_not @book.valid?
  end

  test "name should save in capitalize" do
    mixed_case_name = "physics"
    @book.name = mixed_case_name
    @book.save 
    assert_equal mixed_case_name.capitalize, @book.reload.name
    assert_not_equal mixed_case_name, @book.reload.name
  end

  test "author should save in capitalize" do
    mixed_case_author = "rd barman"
    @book.author = mixed_case_author
    @book.save 
    assert_equal mixed_case_author.capitalize, @book.reload.author
    assert_not_equal mixed_case_author, @book.reload.author
    assert_not File.exists?(@book.picture.file.path)
    assert @book.valid?
  end

  # test "uploads an book image" do
  #   book = Book.create(name:"dcsc",author:"sds",no_of_copies:"2")
  #   # assert(File.exists?(book.reload.picture.file.path))
  # end
end
