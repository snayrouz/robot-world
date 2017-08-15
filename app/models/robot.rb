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
  end

  def self.database
  end

  def self.find(id)
  end

  def self.update(id, params)
  end

  def self.destroy(id)
  end
end
