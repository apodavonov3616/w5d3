require 'sqlite3'
require 'singleton'
require 'pry'


require_relative "likes_database"
require_relative "questions_database"
require_relative "replies_database"
require_relative "users_database"
require_relative "follows_database"


class QuestionsDatabase < SQLite3::Database
    include Singleton
  
    def initialize
      super('questions.db')
      self.type_translation = true
      self.results_as_hash = true
    end
  end

