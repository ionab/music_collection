require('pg')
require_relative("artist.rb")
require_relative("../db/sql_runner.rb")

class Album
  attr_reader :id
  attr_writer :title, :genre, :artist_id

  def initialize(options)
    @id = options["id"].to_i()
    @title = options['title']
    @genre = options['genre']
    @artist_id = options["artist_id"].to_i()
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id;"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i()
  end

  def self.all()
    sql = "SELECT * FROM albums;"
    albums = SqlRunner(sql)
    return albums.map{|album| self.new(album)}
  end

  def self.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4;"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def artist()
    sql ="SELECT * from artists WHERE id = $1;"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    artist_hash = result[0]
    return Artist.new(artist_hash)
  end
end
