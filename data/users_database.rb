require 'sqlite3'
require 'singleton'
require 'pry'
require_relative 'questions_database'

   
class User
      attr_accessor :id, :first_name, :last_name
    
      def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| User.new(datum) }
      end
    
      def initialize(options)
        @id = options['id']
        @first_name = options['first_name']
        @last_name = options['last_name']
      end
    
      def create
        raise "#{self} already in database" if self.id
        QuestionsDatabase.instance.execute(<<-SQL, self.first_name, self.last_name)
          INSERT INTO
            users (first_name, last_name)
          VALUES
            (?, ?)
        SQL
        self.id = QuestionsDatabase.instance.last_insert_row_id
      end
    
      def update
        raise "#{self} not in database" unless self.id
        QuestionsDatabase.instance.execute(<<-SQL, self.first_name, self.last_name, self.id)
          UPDATE
            users
          SET
            first_name = ?, last_name = ?
          WHERE
            id = ?
        SQL
      end
    
      def self.find_by_id(object_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, object_id) 
          SELECT * FROM users WHERE id = ? 
        SQL
        raise "#{object_id} not in database" unless data.first['id']
        User.new(data.first)
      end
    end
    