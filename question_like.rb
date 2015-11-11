class QuestionLike
  attr_accessor :id, :user_id, :question_id

  def initialize(options)
    @id, @user_id, @question_id = options.values_at('id', 'user_id', 'question_id')
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
    QuestionLike.new(data.first)
  end

  def self.likers_for_question_id(q_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, q_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        users
      JOIN
        question_likes ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL
    data.map{ |peoples| User.new(peoples) }
  end

  def self.num_likes_for_question_id(q_id)
    quantity = QuestionsDatabase.instance.execute(<<-SQL, q_id)
      SELECT
        COUNT(*) quant
      FROM
        question_likes
      GROUP BY
        question_id
      HAVING
        question_id = ?
      SQL
      return nil if quantity.empty?
      quantity.first["quant"]
  end

  def self.liked_questions_for_user_id(u_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, u_id)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = ?
    SQL
    data.map{|datum| Question.new(datum)}
  end

  def self.most_liked_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(questions.id) DESC
      LIMIT
        ?
    SQL
      data.map{|datum| Question.new(datum)}
  end

end
