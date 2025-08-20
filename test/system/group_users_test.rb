require "application_system_test_case"

class GroupUsersTest < ApplicationSystemTestCase
  setup do
    @group_user = group_users(:one)
  end

  test "visiting the index" do
    visit group_users_url
    assert_selector "h1", text: "Group users"
  end

  test "should create group user" do
    visit group_users_url
    click_on "New group user"

    fill_in "Group", with: @group_user.group_id
    fill_in "User", with: @group_user.user_id
    click_on "Create Group user"

    assert_text "Group user was successfully created"
    click_on "Back"
  end

  test "should update Group user" do
    visit group_user_url(@group_user)
    click_on "Edit this group user", match: :first

    fill_in "Group", with: @group_user.group_id
    fill_in "User", with: @group_user.user_id
    click_on "Update Group user"

    assert_text "Group user was successfully updated"
    click_on "Back"
  end

  test "should destroy Group user" do
    visit group_user_url(@group_user)
    accept_confirm { click_on "Destroy this group user", match: :first }

    assert_text "Group user was successfully destroyed"
  end
end
