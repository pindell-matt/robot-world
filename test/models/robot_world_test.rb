require_relative '../test_helper'

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_robot
    robot_world.create({
      :name       => "Charles Bronson",
      :avatar     => "a description",
      :birth_date => "12/12/2012"
    })

    robot = robot_world.all.first
    assert_equal "Charles Bronson", robot.name
    assert_equal "a description", robot.avatar
    assert_equal "12/12/2012", robot.birth_date
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

  def test_it_can_find_a_robot
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

    robot = robot_world.all.last
    assert_equal "Steven Urkel", robot.name
    assert_equal "a description", robot.avatar
  end

  def test_it_can_update_a_robot
    robot_world.create({
      :name       => "Charles Bronson",
      :avatar     => "a description",
      :birth_date => "12/12/2012"
    })

    robot = robot_world.all.first

    assert_equal "Charles Bronson", robot.name
    assert_equal "a description", robot.avatar
    assert_equal "12/12/2012", robot.birth_date

    updated = {
      name: "Fancy Pants",
      avatar: "pants2fancy",
      birth_date: "12/12/2011"
    }

    robot_world.update(robot.id, updated)
    robot = robot_world.all.first

    assert_equal "Fancy Pants", robot.name
    assert_equal "pants2fancy", robot.avatar
    assert_equal "12/12/2011", robot.birth_date
  end

  def test_it_can_delete_a_robot
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

    robot_world.destroy(robot_world.all.first.id)
    robots = robot_world.all

    assert_kind_of Array, robots
    assert_equal 1, robots.count
    assert_equal "Steven Urkel", robots.first.name
  end

end
