require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "should create new tag" do
    tag = Tag.new(name: "Valid Tag")
    assert tag.valid?
  end

  test "shouldnt create new tag without name" do
    tag = Tag.new(name: "")
    assert_not tag.valid?
  end

  test "shouldnt create duplicate tag" do
    Tag.create!(name: "Duplicate Tag")
    tag = Tag.new(name: "Duplicate Tag")
    assert_not tag.valid?
  end
end
