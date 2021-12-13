require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @user2 = users(:two)
    
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  # test "creating a User" do
  #   visit users_url
  #   click_on "New User"

  #   fill_in "Credit", with: @user.credit
  #   fill_in "Password digest", with: @user.password_digest
  #   fill_in "Username", with: @user.username
  #   click_on "Create User"

  #   assert_text "User was successfully created"
  #   click_on "Back"
  # end

  # test "updating a User" do
  #   visit users_url
  #   click_on "Edit", match: :first

  #   fill_in "Credit", with: @user.credit
  #   fill_in "Password digest", with: @user.password_digest
  #   fill_in "Username", with: @user.username
  #   click_on "Update User"

  #   assert_text "User was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a User" do
  #   visit users_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "User was successfully destroyed"
  # end

  test "register user" do
    visit main_url
    click_on "Sign up"
    fill_in "Username", with: "aaa"
    fill_in "Password", with: BCrypt::Password.create("aaa")
    fill_in "Credit", with: "1000"
    click_on "Create User"
    assert_text "User was successfully created"
  end

  test "login with right person" do
    visit main_url
    fill_in "Username", with: @user.username
    fill_in "Password", with: "zzz"
    click_on "Login"
    assert_text "Home"
  end

  test "login with wrong username" do
    visit main_url
    fill_in "Username", with: "jjj"
    fill_in "Password", with: @user2.password_digest
    click_on "Login"
    assert_text "Not found this user"
  end

  test "login with wrong password" do
    visit main_url
    fill_in "Username", with: @user2.username
    fill_in "Password", with: BCrypt::Password.create("zzz")
    click_on "Login"
    assert_text "Wrong password"
  end

  test "access not login" do
    visit "/inventory"
    assert_text "Please login."
  end

  test "access not real user" do
    visit main_url
    fill_in "Username", with: @user.username
    fill_in "Password", with: "zzz"
    click_on "Login"
    visit"/banner/#{@user2.id}"
    assert_text "Log in with wrong user"
  end

  test "buy gacha_one" do
    visit main_url
    fill_in "Username", with: @user.username
    fill_in "Password", with: "zzz"
    click_on "Login"
    click_on "Gacha!" , match: :first
    click_on "Get X1"  ,match: :first
    assert_text "1400"
  end

  test "buy gacha_five" do
    visit main_url
    fill_in "Username", with: @user.username
    fill_in "Password", with: "zzz"
    click_on "Login"
    click_on "Gacha!" , match: :first
    click_on "Get X5"  ,match: :first
    assert_text "1100"
  end

  # test "buy_market" do
  #   visit main_url
  #   fill_in "Username", with: @user.username
  #   fill_in "Password", with: "zzz"
  #   click_on "Login"
  #   click_on "Market"
  #   click_on "Buy"
  #   assert_text "15"
  # end
end

