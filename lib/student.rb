class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-TABLE
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade INTEGER
        )
        TABLE
    DB[:conn].execute(sql) 
  end

  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end
    
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create (name:, grade:)
    # name: = name
    # grade: = grade
    student=Student.new(name, grade)
    student.save
    student
  end


  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  # students have two attributes, name and grade


  # class method that creates the students table in db
  # method to drop the table
  # method to save data from individual student 

  #method to create new instance of student class and save to db

end
