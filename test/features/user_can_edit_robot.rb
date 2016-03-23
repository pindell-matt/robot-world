require_relative '../test_helper'

class UserCanEditRobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_create_new_robot
    visit '/'

    click_link_or_button("Create New Robot")
    assert_equal "/robots/new", current_path

    fill_in 'robot[name]', with: "Charles Bronson"
    fill_in 'robot[avatar]', with: "ccccharlesBRONson"
    fill_in 'robot[birth_date]', with: "12/12/2012"

    click_button("Create")
    assert_equal "/robots", current_path

    within(".robot") do
      assert page.has_content?("Charles Bronson")
    end

    click_link_or_button("Edit")
    assert_equal "/robots/1/edit", current_path

    fill_in 'robot[name]', with: "Charlie Brown"

    click_button("Revise")
    assert_equal "/robots/1", current_path

    refute page.has_content?("Charles Bronson")
    assert page.has_content?("Charlie Brown")
  end

end
