require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@student = students(:aman)
  end

  test "should be valid " do 
  	assert @student.valid?
  end

  test "name should be valid" do
  	@student.name = "mamsadcdlacnad"
  	assert @student.valid?
  end

  test "name not valid" do 
  	@student.name = "mamsadcdlacnad"*10
  	assert_not @student.valid?
  	@student.name = ""
  	assert_not @student.valid?
  	@student.name = "  "*10
  	assert_not @student.valid?
  	@student.name = "a"*51
  	assert_not @student.valid?
  end

  test "email not valid " do
  	@student.email = "avdcdd"*10
  	assert_not @student.valid?
  	@student.email = ""
  	assert_not @student.valid?
  	@student.email = "   "
  	assert_not @student.valid?
	end

	test "email address should be unique" do
		@dup_student = @student.dup
		@dup_student.save
  	assert_not @dup_student.valid?
  	@dup_student = @student.dup
  	@dup_student.email = @student.email.upcase
  	@dup_student.save
  	assert_not @dup_student.valid?
	end

	test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @student.email = mixed_case_email
    @student.save
    assert_equal mixed_case_email.downcase, @student.reload.email
    assert_not_equal mixed_case_email, @student.reload.email
  end

  test "name should save in upcase" do
    mixed_case_name = "anshul"
    @student.name = mixed_case_name
    @student.save 
    assert_equal mixed_case_name.upcase, @student.reload.name
    assert_not_equal mixed_case_name, @student.reload.name
  end
end
