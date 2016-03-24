require_relative '../test_helper'

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_robot
    robot_world.create({
      :name       => "Charles Bronson",
      :avatar     => "a description",
      :birth_date => "12/12/2012"
    })

    robot = robot_world.find(1)
    assert_equal "Charles Bronson", robot.name
    assert_equal "a description", robot.avatar
    assert_equal "12/12/2012", robot.birth_date
    assert_equal 1, robot.id
  end

  def test_it_can_return_all_robots
    robot_world.create({
      :name       => "Charles Bronson",
      :avatar     => "a description",
      :birth_date => "12/12/2012"
    })

    robot_world.create({
      :name       => "Steven Urkel",
      :avatar     => "a description",
      :birth_date => "12/12/2012"
    })

    robots = robot_world.all
    assert_kind_of Array, robots
    assert_equal 2, robots.count
    assert_equal "Charles Bronson", robots.first.name
    assert_equal "Steven Urkel", robots.last.name
  end
end