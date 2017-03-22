require 'test_helper'

class UserTest < ActiveSupport::TestCase
	# test "the truth" do
	#   assert true
	# end
	def setup
		@user = User.new(provider: "google", uid: "zweiss", first_name: "Example", last_name: "User", email: "user@example.com", can_host: false)
		@user_is_host = User.new(provider: "google", uid: "acarr", first_name: "Example2", last_name: "User2", email: "user1@example.com", can_host: true)
	end


	# test "should be valid" do
	# 	assert @user.valid?
	# end
	#
	# test "name should be present" do
	# 	@user.first_name = ""
	# 	assert_not @user.valid?
	# end
	#
	# test "email should be present" do
	# 	@user.email = "     "
	# 	assert_not @user.valid?
	# end
	#
	# test "name should not be too long" do
	# 	@user.first_name = "a" * 51
	# 	assert_not @user.valid?
	# end
	#
	# test "email should not be too long" do
	# 	@user.email = "a" * 244 + "@example.com"
	# 	assert_not @user.valid?
	# end
	#
	# test "email validation should accept valid addresses" do
  #   valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
  #                        first.last@foo.jp alice+bob@baz.cn]
  #   valid_addresses.each do |valid_address|
  #     @user.email = valid_address
  #     assert @user.valid?, "#{valid_address.inspect} should be valid"
  #   end
  # end
	#
	# test "email addresses should be unique" do
  #   duplicate_user = @user.dup
  #   @user.save
  #   assert_not duplicate_user.valid?
  # end
	#
	# test "email addresses should be saved as lower-case" do
  #   mixed_case_email = "Foo@ExAMPle.CoM"
  #   @user.email = mixed_case_email
  #   @user.save
  #   assert_equal mixed_case_email.downcase, @user.reload.email
  # end
	#
	# test "password should be present (nonblank)" do
	# 	@user.password = @user.password_confirmation = " " * 6
	# 	assert_not @user.valid?
	# end
	#
	#
	# #min length 6
	# test "password should have a minimum length" do
	# 	@user.password = @user.password_confirmation = "a" * 5
	# 	assert_not @user.valid?
	# end

	test "user is associated with events" do
		@user.save!
		event = @user.events.create(name: "Blah", description: "This is the description.")
		assert_equal 1, @user.events.count
	end



end
