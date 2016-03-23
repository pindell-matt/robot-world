require 'yaml/store'
require_relative 'robot'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.transaction do
      database['robots'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['robots'] << {
                              "id"         => database['total'],
                              "name"       => robot[:name],
                              "city"       => robot[:city],
                              "state"      => robot[:state],
                              "avatar"     => robot[:avatar],
                              "birth_date" => robot[:birth_date],
                              "date_hired" => robot[:date_hired],
                              "department" => robot[:department]
                            }

    end
  end

  def raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def all
    raw_robots.map { |data| Robot.new(data)}
  end

  def raw_robot(id)
    raw_robots.find { |robot| robot["id"] == id }
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(robot, id)
    database.transaction do
      target = database['robots'].find { |data| data["id"] == id }
      target["name"] = robot[:name]
      target["city"] = robot[:city]
      target["state"] = robot[:state]
      target["avatar"] = robot[:avatar]
      target["birth_date"] = robot[:birth_date]
      target["date_hired"] = robot[:date_hired]
      target["department"] = robot[:department]
    end
  end

  def destroy(id)
    database.transaction do
      database['robots'].delete_if { |robot| robot["id"] == id }
    end
  end

  def destroy_all
    database.transaction do
      database['robots'] = []
      database['total'] = 0
    end
  end

  def calc_avg_robot_age
    ages = all.map do |robot|
      Date.today.year - (Date.strptime(robot.birth_date, "%m/%d/%Y").year)
    end
    ages.reduce(:+) / ages.count
  end

  def by_location(location)
    departments = all.map(&location)
    departments.each_with_object(Hash.new(0)) do |loc, hash|
      hash[loc] +=1
    end
  end

end
