require 'sequel'

database = Sequel.sqlite('db/robot_world_test.sqlite')
database.create_table :robots do
  primary_key :id
  String      :name
  String      :city
  String      :state
  String      :avatar
  String      :birth_date
  String      :date_hired
  String      :department
end
