require 'sqlite3'

class Robot
  attr_reader :id, :name, :city, :state, :department, :database
  def initialize(params)
    @id = params["id"]
    @name = params["name"]
    @city = params["city"]
    @state = params["state"]
    @department = params["department"]
    @database = SQLite3::Database.new('db/robot_world_development.db')
    @database.results_as_hash = true
  end

  def save
    @database.execute("INSERT INTO robots (name, city, state, department) VALUES (?, ?, ?, ?)", @name, @city, @state, @department)
  end

  def self.all
    robots = database.execute("SELECT * FROM robots")
    robots.map do |robot|
      Robot.new(robot)
    end
  end

  def self.database
    database = SQLite3::Database.new('db/robot_world_development')
    database.results_as_hash = true
    database
  end

  def self.find(id)
    robot = database.execute("SELECT * FROM robots WHERE id = ?", id).first
    Robot.new(robot)
  end

  def self.update(id, params)
    database.execute("UPDATE robots
                      SET name = ?,
                          city = ?,
                          state = ?,
                          department = ?
                      WHERE id = ?;",
                      params[:name],
                      params[:city],
                      params[:state],
                      params[:department],
                      id)
    Robot.find(id)
  end

  def self.destroy(id)
    database.execute("DELETE FROM robots
                      WHERE id = ?;", id)
  end
end
