require 'sqlite3'
require 'singleton'
require 'pry'



class Question
  attr_accessor :id, :title, :body, :author_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def create
    raise "#{self} already in database" if self.id
    QuestionsDatabase.instance.execute(<<-SQL, self.title, self.body, self.author_id)
      INSERT INTO
        questions (title, body, author_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    QuestionsDatabase.instance.execute(<<-SQL, self.title, self.body, self.author_id, self.id)
      UPDATE
        questions
      SET
        title = ?, body = ?, author_id = ?
      WHERE
        id = ?
    SQL
  end

  def self.find_by_id(object_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, object_id) 
          SELECT * FROM questions WHERE id = ? 
    SQL
    raise "#{object_id} not in database" if data.empty?
    Question.new(data.first)
  end

  # Easy
  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT * FROM questions WHERE author_id = ?
    SQL
    raise "#{author_id} not in database" if data.empty?
    data.map { |datum| Question.new(datum) }
  end


  def author 
    User.find_by_id(author_id)
  end


  def replies
    Reply.find_by_question_id(id)
  end



  # Medium
  def followers 
    Follow.followers_for_question_id(id)
  end



  # Hard
  def self.most_followed(n)
    Follow.most_followed_questions(n)
  end

  def likers

  end
  
  def num_likes

  end

  def self.most_liked(n)

  end
end

