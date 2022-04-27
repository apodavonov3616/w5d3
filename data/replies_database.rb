require 'sqlite3'
require 'singleton'
require 'pry'
require_relative 'questions_database'

   
class Reply 
      attr_accessor :id, :question_id, :author_id, :parent_reply, :body
      
      def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map { |datum| Reply.new(datum) }
      end
    
      def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @author_id = options['author_id']
        @parent_reply = options['parent_reply']
        @body = options['body']
      end
    
      def create
        raise "#{self} already in database" if self.id
        QuestionsDatabase.instance.execute(<<-SQL, self.question_id, self.author_id, self.parent_reply, self.body)
          INSERT INTO
            replies (question_id, author_id, parent_reply, body)
          VALUES
            (?, ?, ?, ?)
        SQL
        self.id = QuestionsDatabase.instance.last_insert_row_id
      end
    
      def update
        raise "#{self} not in database" unless self.id
        QuestionsDatabase.instance.execute(<<-SQL, self.question_id, self.author_id, self.parent_reply, self.body, self.id)
          UPDATE
            replies
          SET
            question_id = ?, author_id = ?, parent_reply = ?, body = ?
          WHERE
            id = ?
        SQL
      end
    
      def self.find_by_id(object_id)
          data = QuestionsDatabase.instance.execute(<<-SQL, object_id) 
            SELECT * FROM replies WHERE id = ? 
          SQL
          raise "#{object_id} not in database" if data.empty?
          Reply.new(data.first)
      end
end
    