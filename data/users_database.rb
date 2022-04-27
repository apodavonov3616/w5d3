require 'sqlite3'


   
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
        raise "#{object_id} not in database" if data.empty?
        User.new(data.first)
      end

      # Easy
      def self.find_by_name(f_name, l_name)
        data = QuestionsDatabase.instance.execute(<<-SQL, f_name, l_name) 
          SELECT * FROM users WHERE first_name LIKE ? AND last_name LIKE ? 
        SQL
        raise "#{f_name} not in database" if data.empty?
        User.new(data.first)
      end

      def authored_questions 
        Question.find_by_author_id(self.id)
      end

      def authored_replies 
        Reply.find_by_user_id(self.id)
      end


      # Medium
      def followed_questions
        Follow.followed_questions_for_user_id(id)
      end


      # Hard
      def liked_questions
        Like.liked_questions_for_user_id(id)
      end


      def average_karma
        data = QuestionsDatabase.get_first_value(<<-SQL, self.id)
          SELECT CAST(COUNT(question_likes.id) AS FLOAT)) / COUNT(DISTINCT questions.id) AS karma
          FROM questions
          LEFT OUTER JOIN question_likes
          ON question.id = question_likes.question_id
          WHERE questions.author_id = ?
        SQL
        
      end

    end

    # questions = authored_questions 
    #     total_likes = 0
    #     questions.each do |question|
    #       total_likes += question.num_likes
    #     end
    #     total_likes * 1.0 / questions.length

