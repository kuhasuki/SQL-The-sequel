DROP TABLE IF EXISTS users;

CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('John', 'Doe'),
  ('Paul', 'McCartney');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('Query', 'How do write SQL?', (SELECT id FROM users WHERE fname = 'Paul' AND lname = 'McCartney')),
  ('Help', 'How do you know if been bitten by a cobra?', (SELECT id FROM users WHERE fname = 'John' AND lname = 'Doe'));

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'John' AND lname = 'Doe'), (SELECT id FROM questions WHERE title = 'Query')),
  ((SELECT id FROM users WHERE fname = 'Paul' AND lname = 'McCartney'), (SELECT id FROM questions WHERE title = 'Help'));

INSERT INTO
  replies(question_id, reply_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'Help'), NULL, (SELECT id FROM users WHERE fname = 'Paul' AND lname = 'McCartney'), 'Have you checked for fang marks?'),
  ((SELECT id FROM questions WHERE title = 'Help'), (SELECT id FROM replies WHERE body = 'Have you checked for fang marks?'), (SELECT id FROM users WHERE fname = 'John' AND lname = 'Doe'), 'Good call, was a bear bite actually.');

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'John' AND lname = 'Doe'), (SELECT id FROM questions WHERE title = 'Query')),
  ((SELECT id FROM users WHERE fname = 'Paul' AND lname = 'McCartney'), (SELECT id FROM questions WHERE title = 'Help'));
