require( 'pg' )

class Bounty

  attr_accessor :name, :species, :bounty_value, :danger_level
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value']
    @danger_level = options['danger_level']
    @id = options['id'].to_i if options['id']
  end

  def save()
    #connect to database
    db = PG.connect( { dbname: 'space_cowboy',
                        host: 'localhost'})
    # write sql statement
    sql = "INSERT INTO space_cowboy
    (
      name,
      species,
      bounty_value,
      danger_level
      )
      VALUES ($1, $2, $3, $4)
      RETURNING id
      "
      # create values array to avoid injection attack
      values = [@name, @species, @bounty_value, @danger_level]
      #prepare database
      db.prepare("save", sql)
      #confirm id tag
      @id = db.exec_prepared("save", values) [0]["id"].to_i
      #close database connection
      db.close()
  end

  def Bounty.all()
    db = PG.connect( { dbname: 'space_cowboy',
                        host: 'localhost'})
    sql = "SELECT * FROM space_cowboy"
    db.prepare("all", sql)
    bounties = db.exec_prepared("all")
    db.close()
    return bounties.map { |each_bounty| Bounty.new(each_bounty)}

  end

# write a class method to delete all bounties from database
  def Bounty.delete_all()
    db = PG.connect( { dbname: 'space_cowboy',
                        host: 'localhost'})
    sql = "DELETE FROM space_cowboy"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  # to delete individual bounties, create instance method
  def delete()
    db = PG.connect( { dbname: 'space_cowboy',
                        host: 'localhost'})
    sql = "DELETE FROM space_cowboy WHERE id = $1"
    values = [@id]
    #instead of using id = @id, we reference to seperate array to prevent injection attack
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

# write instance method to update individual bounties
  def update()
    db = PG.connect( { dbname: 'space_cowboy',
                        host: 'localhost'})
    sql = "UPDATE space_cowboy
    SET   (
      name,
      species,
      bounty_value,
      danger_level
      ) =
      (
        $1, $2, $3, $4
      )
      WHERE id = $5
      "
      values = [@name, @species, @bounty_value, @danger_level, @id]
      db.prepare("update", sql)
      db.exec_prepared("update", values)
      db.close()
  end

  # def Bounty.find_by_name(name)
  #   db = PG.connect( { dbname: 'space_cowboy',
  #                       host: 'localhost'})
  #   sql = "SELECT name FROM space_cowboy WHERE name = $1"
  #   values = [@name]
  #   db.prepare("find_by_name", sql)
  #   bounty_name = db.exec_prepared("find_by_name")
  #   db.close()
  #   return bounty_name
  # end
  #





end
