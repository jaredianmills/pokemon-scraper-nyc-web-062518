class Pokemon

  attr_reader :name, :type, :db, :id
  attr_accessor :hp

  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
    @@all << self
  end

  @@all = []

  def self.all
    @@all
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) values (?, ?)", name, type)
  end

  def self.find(id, db)
    new_pokemon = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
    # binding.pry
    Pokemon.new(id: new_pokemon[0], type: new_pokemon[2], name: new_pokemon[1], db: db)
  end

  def alter_hp(hp, db)
    id = self.id
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", hp, id)
  end

end
