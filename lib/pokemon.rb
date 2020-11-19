class Pokemon
    attr_accessor :name,:type,:db, :id
    def initialize(name:,type:,id:nil,db:)
        @name = name
        @type = type
        @db = db
        @id = id
    end

    def self.save(name,type,db)
        sql = <<-SQL
            INSERT INTO pokemon (name,type) VALUES (?,?)
        SQL
        db.execute(sql,name,type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id,db)
        sql = "SELECT * FROM pokemon WHERE id = ?"
        row = db.execute(sql,id)[0]
        self.new(name:row[1],type:row[2],id:row[0],db:db)
    end
end
