require 'Singleton'
require 'SQLite3'
require_relative 'question'
require_relative 'reply'
require_relative 'user'
require_relative 'questionfollow'
require_relative 'question_like'


class QuestionsDatabase < SQLite3::Database
  include Singleton
  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end

# q = Question.find_by_id(1)
# puts q.author
p QuestionFollow.followers_for_question_id(1)
p QuestionFollow.followed_questions_for_user_id(1)
