
class Robot
  attr_reader :id, :name, :city, :state, :avatar, :birth_date,
              :date_hired, :department

  def initialize(data)
    @id         = data["id"]
    @name       = data["name"]
    @city       = data["city"]
    @state      = data["state"]
    @avatar     = data["avatar"]
    @birth_date = data["birth_date"]
    @date_hired = data["date_hired"]
    @department = data["department"]
  end
end
