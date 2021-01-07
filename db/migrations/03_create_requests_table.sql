CREATE TABLE requests (id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users(id), requested_date date, space_id INTEGER REFERENCES spaces(id), status VARCHAR(100));

# play
CREATE TABLE requests (id SERIAL PRIMARY KEY, requester_id INTEGER REFERENCES users(id), requested_date date, space_id INTEGER REFERENCES spaces(id), status VARCHAR(100));

# inner join works
SELECT * FROM requests INNER JOIN spaces ON spaces.id = requests.space_id WHERE requester_id = #{user_id});


SELECT description, price, requested_date FROM requests INNER JOIN spaces ON spaces.id = requests.space_id;
