require_relative('models/artist.rb')
require_relative('models/album.rb')

require('pry-byebug')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new(
  {"name" => "Pink Floyd"}
)

artist1.save()

album1 = Album.new(
  {
    "title" => "Dark Side of the Moon",
    "genre" => "Rock",
    "artist_id" => artist1.id
  }
)

album1.save()

album2 = Album.new(
  {
    "title" => "Wish you were here",
    "genre" => "Rock",
    "artist_id" => artist1.id
  }
)

album2.save()

binding.pry
nil
