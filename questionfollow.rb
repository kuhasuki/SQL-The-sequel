require_relative 'questions_database'

class QuestionFollow
  attr_accessor :id, :user_id, :question_id

  def initialize(options)
    @id, @user_id, @question_id = options.values_at('id', 'user_id', 'question_id')
  end


end
