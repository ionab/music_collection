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

  def self.all()
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    return artists.map{|artist| self.new(artist)}
   end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
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

  def self.find_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
    result_hash = result[0]  #convert here from database object to a ruby object
    return Artist.new(result_hash)
  end

end
