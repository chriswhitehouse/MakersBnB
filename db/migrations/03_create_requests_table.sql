CREATE TABLE requests (id SERIAL PRIMARY KEY, requester_id INTEGER REFERENCES users(id), requested_date date, space_id INTEGER REFERENCES spaces(id), status VARCHAR(100));
