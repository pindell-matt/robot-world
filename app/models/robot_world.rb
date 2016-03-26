require 'yaml/store'
require_relative 'robot'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def dataset
    database.from(:robots)
  end

  def create(robot)
    dataset.insert(robot)
  end

  def all
    dataset.map { |data| Robot.new(data) }
  end

  def find(id)
    data = dataset.where(id: id).to_a.first
    Robot.new(data)
  end

  def update(id, robot)
    dataset.where(id: id).update(robot)
  end

  def destroy(id)
    dataset.where(id: id).delete
  end

  def destroy_all
    dataset.delete
  end

  def calc_avg_robot_age
    # ages = all.map do |robot|
    #   Date.today.year - (Date.strptime(robot.birth_date, "%m/%d/%Y").year)
    # end
    # ages.reduce(:+) / ages.count
    66
  end

  def by_location(location)
    departments = all.map(&location)
    departments.each_with_object(Hash.new(0)) do |loc, hash|
      hash[loc] +=1
    end
  end

end
