PRAGMA foreign_keys = ON;

CREATE TABLE users (
      id INTEGER PRIMARY KEY,
      first_name VARCHAR(100) NOT NULL,
      last_name VARCHAR(100) NOT NULL
);

CREATE TABLE questions (
      id INTEGER PRIMARY KEY,
      title VARCHAR(100) NOT NULL,
      body TEXT NOT NULL,
      author_id INTEGER NOT NULL,
      FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
      id INTEGER PRIMARY KEY,
      user_id INTEGER, 
      question_id INTEGER, 
      FOREIGN KEY (user_id) REFERENCES users(id),
      FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
      id INTEGER PRIMARY KEY,
      question_id INTEGER,
      author_id INTEGER,
      parent_reply INTEGER,
      body TEXT NOT NULL,

      FOREIGN KEY (parent_reply) REFERENCES replies(id),
      FOREIGN KEY (question_id) REFERENCES questions(id),
      FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
      id INTEGER PRIMARY KEY,
      user_id INTEGER,
      question_id INTEGER,
      FOREIGN KEY (user_id) REFERENCES users(id),
      FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO 
      users(first_name, last_name)
VALUES 
      ('Gabriel', 'Groenendaal'),
      ('Alisher', 'Poda'),
      ('Kin Ka', 'InstructorMan'),
      ('Ayce', 'The Mace'),
      ('Victor', 'The Stricter'),
      ('Spencer', 'The Fencer'),
      ('Nikhil', 'The Steal'),
      ('Evan', 'Eleven'),
      ('Karen', 'Polanco'),
      ('Grandma', 'Groenendaal');

INSERT INTO 
      questions(title, body, author_id)
VALUES
      ('Do I have the normal amount of eyes?', 'I feel I have too many eyes, eyes on the inside', (SELECT id FROM users WHERE first_name = 'Victor')),
      ('Are the students noticing my cool hats?', 'My hats are fun and quirky but I do not know if people notice', (SELECT id FROM users WHERE first_name = 'Ayce')),
      ('Are we ever going to get off the Mac Minis?', 'The minis are terrible and I hate them, can we get rid of them?', (SELECT id FROM users WHERE first_name = 'Gabriel')),
      ('Hello, is anyone there?', 'Is this facebook? Find Grandson wedding', (SELECT id FROM users WHERE first_name = 'Grandma')),
      ('Did the entire cohort fall apart while I was on vacation?', 'Please I am pretty sure Victor is planning a coup', (SELECT id FROM users WHERE first_name = 'Kin Ka'));

INSERT INTO 
      question_follows(user_id, question_id)
VALUES 
      ((SELECT id FROM users WHERE first_name = 'Ayce'), (SELECT id FROM questions WHERE title = 'Do I have the normal amount of eyes?')),
      ((SELECT id FROM users WHERE first_name = 'Victor'), (SELECT id FROM questions WHERE title = 'Do I have the normal amount of eyes?')),
      ((SELECT id FROM users WHERE first_name = 'Gabriel'), (SELECT id FROM questions WHERE title = 'Do I have the normal amount of eyes?')),
      ((SELECT id FROM users WHERE first_name = 'Alisher'), (SELECT id FROM questions WHERE title = 'Do I have the normal amount of eyes?')),
      ((SELECT id FROM users WHERE first_name = 'Spencer'), (SELECT id FROM questions WHERE title = 'Do I have the normal amount of eyes?')),
      ((SELECT id FROM users WHERE first_name = 'Ayce'), (SELECT id FROM questions WHERE title = 'Are the students noticing my cool hats?')),
      ((SELECT id FROM users WHERE first_name = 'Victor'), (SELECT id FROM questions WHERE title = 'Are the students noticing my cool hats?')),
      ((SELECT id FROM users WHERE first_name = 'Gabriel'), (SELECT id FROM questions WHERE title = 'Are the students noticing my cool hats?')),
      ((SELECT id FROM users WHERE first_name = 'Alisher'), (SELECT id FROM questions WHERE title = 'Are the students noticing my cool hats?')),
      ((SELECT id FROM users WHERE first_name = 'Spencer'), (SELECT id FROM questions WHERE title = 'Are the students noticing my cool hats?')),
      ((SELECT id FROM users WHERE first_name = 'Karen'), (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?')),
      ((SELECT id FROM users WHERE first_name = 'Kin KA'), (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?')),
      ((SELECT id FROM users WHERE first_name = 'Nikhil'), (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?')),
      ((SELECT id FROM users WHERE first_name = 'Grandma'), (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?')),
      ((SELECT id FROM users WHERE first_name = 'Evan'), (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?')),
      ((SELECT id FROM users WHERE first_name = 'Gabriel'), (SELECT id FROM questions WHERE title = 'Hello, is anyone there?')),
      ((SELECT id FROM users WHERE first_name = 'Spencer'), (SELECT id FROM questions WHERE title = 'Hello, is anyone there?')),
      ((SELECT id FROM users WHERE first_name = 'Evan'), (SELECT id FROM questions WHERE title = 'Hello, is anyone there?'));
      
INSERT INTO 
      question_likes(user_id, question_id)
VALUES 
      ((SELECT id FROM users WHERE first_name = 'Ayce'), (SELECT id FROM questions WHERE title = 'Do I have the normal amount of eyes?')),
      ((SELECT id FROM users WHERE first_name = 'Victor'), (SELECT id FROM questions WHERE title = 'Do I have the normal amount of eyes?')),
      ((SELECT id FROM users WHERE first_name = 'Gabriel'), (SELECT id FROM questions WHERE title = 'Do I have the normal amount of eyes?')),
      ((SELECT id FROM users WHERE first_name = 'Alisher'), (SELECT id FROM questions WHERE title = 'Do I have the normal amount of eyes?')),
      ((SELECT id FROM users WHERE first_name = 'Spencer'), (SELECT id FROM questions WHERE title = 'Do I have the normal amount of eyes?')),
      ((SELECT id FROM users WHERE first_name = 'Ayce'), (SELECT id FROM questions WHERE title = 'Are the students noticing my cool hats?')),
      ((SELECT id FROM users WHERE first_name = 'Victor'), (SELECT id FROM questions WHERE title = 'Are the students noticing my cool hats?')),
      ((SELECT id FROM users WHERE first_name = 'Gabriel'), (SELECT id FROM questions WHERE title = 'Are the students noticing my cool hats?')),
      ((SELECT id FROM users WHERE first_name = 'Alisher'), (SELECT id FROM questions WHERE title = 'Are the students noticing my cool hats?')),
      ((SELECT id FROM users WHERE first_name = 'Spencer'), (SELECT id FROM questions WHERE title = 'Are the students noticing my cool hats?')),
      ((SELECT id FROM users WHERE first_name = 'Karen'), (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?')),
      ((SELECT id FROM users WHERE first_name = 'Kin KA'), (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?')),
      ((SELECT id FROM users WHERE first_name = 'Nikhil'), (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?')),
      ((SELECT id FROM users WHERE first_name = 'Grandma'), (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?')),
      ((SELECT id FROM users WHERE first_name = 'Evan'), (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?')),
      ((SELECT id FROM users WHERE first_name = 'Gabriel'), (SELECT id FROM questions WHERE title = 'Hello, is anyone there?')),
      ((SELECT id FROM users WHERE first_name = 'Spencer'), (SELECT id FROM questions WHERE title = 'Hello, is anyone there?')),
      ((SELECT id FROM users WHERE first_name = 'Evan'), (SELECT id FROM questions WHERE title = 'Hello, is anyone there?'));
      
INSERT INTO
      replies(question_id, author_id, parent_reply, body)
VALUES
      (
            (SELECT id FROM questions WHERE title = 'Are the students noticing my cool hats?'),
            (SELECT id FROM users WHERE first_name = 'Alisher'),
            NULL,
            'Kin Ka is noticing the cool hats. I cannot speak for the students. Write better question instructions.'
      ),
      (
            (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?'),
            (SELECT id FROM users WHERE first_name = 'Victor'),
            NULL,
            'I have taken the students hostage, you cannot win now'
      ),
      (
            (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?'),
            (SELECT id FROM users WHERE first_name = 'Victor'),
            NULL,
            'I have taken the students hostage, you cannot win now'
      );

INSERT INTO
      replies(question_id, author_id, parent_reply, body)
VALUES
      (
            (SELECT id FROM questions WHERE title = 'Are the students noticing my cool hats?'),
            (SELECT id FROM users WHERE first_name = 'Ayce'),
            (SELECT id FROM replies WHERE body LIKE 'Kin Ka is noticing the cool hats. I cannot speak for the students. Write better question instructions.'),
            'Thank you so much. I try'
      ),
      (
            (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?'),
            (SELECT id FROM users WHERE first_name = 'Kin Ka'),
            (SELECT id FROM replies WHERE body LIKE 'I have taken the students hostage, you cannot win now'),
            'Oh god no! Not the students!'
      ),
      (
            (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?'),
            (SELECT id FROM users WHERE first_name = 'Alisher'),
            (SELECT id FROM replies WHERE body LIKE 'I have taken the students hostage, you cannot win now'),
            'Help us Kin Ka, we are going to die'
      ),
      (
            (SELECT id FROM questions WHERE title = 'Did the entire cohort fall apart while I was on vacation?'),
            (SELECT id FROM users WHERE first_name = 'Gabriel'),
            (SELECT id FROM replies WHERE body LIKE 'Help us Kin Ka, we are going to die'),
            'Silence swine. Us Victor loyalists will prevail!'
      );