require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(first_name: "John", last_name: "Doe", is_host: true, bio: "This is my bio", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  # test "should create user" do
	# 	byebug
  #   assert_difference('User.count') do
  #     post users_url, params: { user: { bio: @user.bio, email: @user.email + "Unique@abc.com", first_name: @user.first_name, is_host: @user.is_host, last_name: @user.last_name } }
  #   end
	#
  #   assert_redirected_to user_url(User.last)
  # end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end
	# 
  # test "should update user" do
  #   patch user_url(@user), params: { user: { bio: @user.bio, email: @user.email, first_name: @user.first_name, is_host: @user.is_host, last_name: @user.last_name } }
  #   assert_redirected_to user_url(@user)
  # end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
