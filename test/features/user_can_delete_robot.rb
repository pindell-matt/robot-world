require_relative '../test_helper'

class UserCanDeleteRobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_delete_robot
    visit '/'

    click_link_or_button("Create New Robot")
    assert_equal "/robots/new", current_path

    fill_in 'robot[name]', with: "Charles Bronson"
    fill_in 'robot[avatar]', with: "ccccharlesBRONson"
    fill_in 'robot[birth_date]', with: "12/12/2012"

    click_button("create-robot")
    assert_equal "/robots", current_path

    within(".robot") do
      assert page.has_content?("Charles Bronson")
    end

    click_link_or_button("Delete")

    assert_equal "/robots", current_path
    refute page.has_content?("Charles Bronson")
  end

end
