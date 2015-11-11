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
p us = QuestionFollow.followers_for_question_id(1)
# p qs = QuestionFollow.followed_questions_for_user_id(2)
p us.first
p us.first.average_karma
# p qs.first.followers
#
# p QuestionFollow.most_followed_questions(2)
# p QuestionLike.likers_for_question_id(2)
# p QuestionLike.num_likes_for_question_id(2)
# p QuestionLike.liked_questions_for_user_id(1)
# p QuestionLike.most_liked_questions(4)
# j = User.new({"fname" => "michael", "lname" => "jordan"})
# j.fname = "David"
# j.lname = "Copperfield"
# j.save
p User.find_by_id(13)
