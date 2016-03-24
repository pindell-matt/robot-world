
class RobotWorldApp < Sinatra::Base
  # set :root, File.expand_path("..", __dir__)
  # set :method_override, true

  get '/' do
    @avg_age = robot_world.calc_avg_robot_age
    @by_department = robot_world.by_location(:department)
    @by_city = robot_world.by_location(:city)
    @by_state = robot_world.by_location(:state)
    erb :dashboard
  end

  get '/robots' do
    @robots = robot_world.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    robot_world.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |id|
    @robot = robot_world.find(id.to_i)
    erb :show
  end

  get '/robots/:id/edit' do |id|
    @robot = robot_world.find(id.to_i)
    erb :edit
  end

  put '/robots/:id' do |id|
    robot_world.update(params[:robot], id.to_i)
    redirect "/robots/#{id}"
  end

  delete '/robots/:id' do |id|
    robot_world.destroy(id.to_i)
    redirect '/robots'
  end

  def robot_world
    if ENV["RACK_ENV"] == "test"
      database = Sequel.sqlite('db/robot_world_test.sqlite')
    else
      database = Sequel.sqlite('db/robot_world_development.sqlite')
    end
    @robot_world ||= RobotWorld.new(database)
  end

end
