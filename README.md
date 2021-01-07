# MakersBnB

MakersBnB is a webapp that allows users to list spaces they have available and to hire spaces for the night.

## Build Status

[![Build Status](https://travis-ci.com/ZeenLamDev/MakersBnB.svg?branch=master)](https://travis-ci.com/ZeenLamDev/MakersBnB)

## Code style
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)

## User Stories
Any signed-up user can list a new space.
```
1. As a user
So I can use makersBnb.
I would like to sign up
```
```
2. As a user
So I can make changes to my bookings/listings
I would like to log in
```
```
3. As a user
So i can protect my bookings/listings
I would like to log out
```
```
4. As a user
So i can choose a space
I would like to see a list of spaces
```
```
5. As a user
So i can see spaces in a specified date range
I would like to be able to filter the list by date of availibility.
```
```
6. As a owner
So i could rent out a space
I would like to list a space.
```
```
7. As a owner
So i could rent out multiple spaces
I would like to list multiple spaces
```
```
8. As a owner
So i can give details of my space
I would like to provide a name, description & price per night
```
```
9. As a owner
So i can manage availibility
I would like to be able to offer a range of availible dates
```
```
10. As a user
So that i can rent an owners space
I would like to be able to request an owners space for one night
```
```
11. As a owner
So i can approve a booking
I would like to be able to approve bookings on my space
```
```
12. As a user
So spaces dont get double booked
It should not allow me to book a date that has already been booked
```
```
13. As a owner
Untill i confirm a booking
It should still be available
```

### Diagramming

![Class Diagram](https://github.com/ZeenLamDev/MakersBnB/blob/master/diagrams/class.svg)
![Entity](https://github.com/ZeenLamDev/MakersBnB/blob/master/diagrams/entity.svg)
![Sequence](https://github.com/ZeenLamDev/MakersBnB/blob/master/diagrams/sequence.svg)

### Database Setup

1. Connect to psql
2. Create a development database using the psql command `CREATE DATABASE makersbnb;`
3. Run '01_create_users_table.sql'
4. Run '02_create_spaces_table.sql'
5. Run '03_create_requests_table.sql'
5. Complete above steps for `CREATE DATABASE makersbnb_test;`
