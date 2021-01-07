CREATE TABLE spaces (id SERIAL PRIMARY KEY, name VARCHAR(60), description VARCHAR(240), price INTEGER, date_available_from DATE, date_available_to DATE, user_id INTEGER REFERENCES users(id));

# play
CREATE TABLE spaces (id SERIAL PRIMARY KEY, name VARCHAR(60), description VARCHAR(240), price INTEGER, date_available_from DATE, date_available_to DATE, owner_id INTEGER REFERENCES users(id));
