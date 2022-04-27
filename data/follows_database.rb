require 'sqlite3'
require_relative 'dummy'

   
class Follow
      attr_accessor :id, :user_id, :question_id
    
      def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        data.map { |datum| Follow.new(datum) }
      end
    
      def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
      end
    
      def create
        raise "#{self} already in database" if self.id
        QuestionsDatabase.instance.execute(<<-SQL, self.user_id, self.question_id)
          INSERT INTO
            question_follows (user_id, question_id)
          VALUES
            (?, ?)
        SQL
        self.id = QuestionsDatabase.instance.last_insert_row_id
      end
    
      def update
        raise "#{self} not in database" unless self.id
        QuestionsDatabase.instance.execute(<<-SQL, self.user_id, self.question_id, self.id)
          UPDATE
            question_follows
          SET
            user_id = ?, question_id = ?
          WHERE
            id = ?
        SQL
      end
    
      def self.find_by_id(object_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, object_id) 
          SELECT * FROM question_follows WHERE id = ? 
        SQL
        raise "#{object_id} not in database" if data.empty?
        Follow.new(data.first)
      end
    end