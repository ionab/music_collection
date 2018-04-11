require('pg')
require_relative("album.rb")
require_relative("../db/sql_runner.rb")

class Artist

  attr_reader :id, :name

  def initialize(options)
    @id = options["id"].to_i()
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id;"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE artist SET (name) = ($1) WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def albums()
    sql = "SELECT * from albums WHERE artist_id = $1;"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map{|album| Album.new(album)}
  end

end
