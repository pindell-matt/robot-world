class RobotWorldApp < Sinatra::Base

  get '/' do
    @avg_age        = robot_world.calc_avg_robot_age
    @by_department  = robot_world.by_location(:department)
    @by_city        = robot_world.by_location(:city)
    @by_state       = robot_world.by_location(:state)
    @hires_per_year = robot_world.hires_per_year
    erb :dashboard
  end

  get '/robots' do
    @robots = robot_world.all
    erb :index
  end

  # get '/robots' do
  #   if params[:name]
  #     @robots = robot_world.find_by(name: params[:name])
  #   else
  #     @robots = robot_world.all
  #   end
  #   erb :index
  # end

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
    robot_world.update(id.to_i, params[:robot])
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
