require 'sequel'

database = Sequel.sqlite('db/robot_world_development.sqlite')
database.drop_table :robots

database = Sequel.sqlite('db/robot_world_test.sqlite')
database.drop_table :robots
