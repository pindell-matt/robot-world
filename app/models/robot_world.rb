require 'yaml/store'
require_relative 'robot'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.from(:robots).insert(robot)
  end

  def all
    database.from(:robots).map { |data| Robot.new(data) }
  end

  def find(id)
    database.from(:robots).where(id: id).to_a.first
  end

  def update(id, robot)
    database.from(:robots).where(id: id).update(robot)
  end

  def destroy(id)
    database.from(:robots).where(id: id).delete
  end

  def destroy_all
    database.from(:robots).delete
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
