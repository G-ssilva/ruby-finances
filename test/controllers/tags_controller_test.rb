require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest

  setup do
    post session_url, params: { email_address: "one@example.com", password: "password" }
    @tag = tags(:one)
  end

  test "should display new tag form" do
    get new_tag_url
    assert_response :success
  end

  test "should save new tag" do
    assert_difference("Tag.count") do
      post tags_url, params: { tag: { name: "New Tag" } }
    end
    assert_redirected_to tag_url(Tag.last)
  end

  test "shouldnt save new tag with empty name" do
    assert_no_difference("Tag.count") do
      post tags_url, params: { tag: { name: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "shouldnt save duplicate tag" do
    assert_no_difference("Tag.count") do
      post tags_url, params: { tag: { name: @tag.name } }
    end

    assert_response :unprocessable_entity
  end

  test "should display all tags" do
    get tags_url
    assert_response :success
    assert_not_nil assigns(:tags)
  end

  test "should display a tag" do
    get tag_url(@tag)
    assert_response :success
  end

  test "should display edit tag form" do
    get edit_tag_url(@tag)
    assert_response :success
  end

  test "should update existing tag" do
    new_name = "Updated Tag"
    patch tag_url(@tag), params: { tag: { name: new_name } }

    @tag.reload
    assert_equal new_name, @tag.name

    assert_redirected_to tag_url(@tag)
  end

  test "shouldnt update new tag with empty name" do
    patch tag_url(@tag), params: { tag: { name: "" } }

    @tag.reload
    assert_not_equal "", @tag.name

    assert_response :unprocessable_entity
  end

  test "should delete tag" do
    assert_difference("Tag.count", -1) do
      delete tag_url(@tag)
    end
    assert_redirected_to tags_url
  end
end
