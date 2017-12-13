class Student

	attr_accessor :name, :grade
	attr_reader :id

	def initialize(name, grade, id=nil)
		@name = name
		@grade = grade
		@id = id
	end

	def self.create_table
		DB[:conn].execute("CREATE TABLE students (
			id INTEGER PRIMARY KEY,
			name TEXT,
			grade INTEGER);")		
	end

	def self.drop_table
		DB[:conn].execute("DROP TABLE students;")
	end
  
	def save
		sql = <<-SQL
			INSERT INTO students (name, grade) VALUES
			(?, ?)
			SQL
		DB[:conn].execute(sql, [self.name, self.grade])
		@id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
	end

	def self.create(params)
		student = Student.new(params[:name], params[:grade])
		student.save
		student
	end

end
