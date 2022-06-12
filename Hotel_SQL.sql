CREATE TABLE hotel ( 
    hotel_no CHAR(4) NOT NULL, 
    name VARCHAR(20) NOT NULL, 
    address VARCHAR(50) NOT NULL
    );
CREATE TABLE room ( 
    room_no VARCHAR(4) NOT NULL, 
    hotel_no CHAR(4) NOT NULL, 
    type CHAR(1) NOT NULL, 
    price DECIMAL(5,2) NOT NULL);
CREATE TABLE booking_old (
    hotel_no CHAR(4) NOT NULL, 
    guest_no CHAR(4) NOT NULL, 
    date_from DATETIME NOT NULL, 
    date_to DATETIME NULL, 
    room_no CHAR(4) NOT NULL);
CREATE TABLE guest( 
guest_no CHAR(4) NOT NULL, 
name VARCHAR(20) NOT NULL, 
address VARCHAR(50) NOT NULL);

iNSERT INTO hotel 
VALUES 
('H111', 'Grosvenor Hotel', 'London');
INSERT INTO room 
VALUES 
('1', 'H111', 'S', 72.00);
INSERT INTO guest 
VALUES 
('G111', 'John Smith', 'London');
INSERT INTO booking_old 
VALUES 
('H111', 'G111', DATE'1999-01-01', DATE'1999-01-02', '1');

UPDATE room SET price = price*1.05;

CREATE TABLE booking_old_old ( 
    hotel_no CHAR(4) NOT NULL, 
    guest_no CHAR(4) NOT NULL, 
    date_from DATETIME NOT NULL, 
    date_to DATETIME NULL, 
    room_no VARCHAR(4) NOT NULL);
INSERT INTO booking_old_old 
(SELECT * FROM booking_old 
WHERE date_to < DATE'2000-01-01'); 
DELETE FROM booking_old 
WHERE date_to < DATE'2000-01-01';

----------------------------------------------------------------------------------------------------------------------------




--list full details of all hotels
SELECT * from hotel;

--List full details of all hotels in London
SELECT * from hotel WHERE address = 'London'; 

--List the names and addresses of all guests in London, alphabetically ordered by name.
SELECT name, address FROM guest WHERE address = 'London' ORDER BY name; 

--List all double or family rooms with a price below £40.00 per night, in ascending order of price.
SELECT * FROM room WHERE type = 'F' OR type = 'D' AND price < 40.00 ORDER BY price;

--List the booking_olds for which no date_to has been specified.
SELECT * FROM booking_old WHERE date_to IS NULL;

--How many hotels are there?
SELECT distinct count(hotel_no) FROM hotel;

--What is the average price of a room?
SELECT avg(price) FROM room;

--What is the total revenue per night from all double rooms? 
SELECT sum(price)/COUNT(price) FROM room WHERE type = 'D';

--How many different guests have made booking_olds for August?
SELECT distinct count(guest_no) FROM booking_old WHERE month(date_from) = 08;

--List the price and type of all rooms at the Grosvenor Hotel.
SELECT type,price from room natural join hotel
WHERE name = 'Grosvenor Hotel';

--List all guests currently staying at the Grosvenor Hotel.
SELECT g.name from guest g 
join booking_old_old b on g.guest_no = b.guest_no
join hotel h ON b.hotel_no = h.hotel_no
WHERE h.name = 'Grosvenor Hotel';

--List the details of all rooms at the Grosvenor Hotel, 
--including the name of the guest staying in the room, if the room is occupied. 
SELECT r.*,g.name FROM room r
JOIN hotel h ON r.hotel_no = h.hotel_no
JOIN booking_old b ON r.hotel_no = b.hotel_no
JOIN guest g ON b.guest_no = g.guest_no
WHERE h.name = 'Grosvenor Hotel';

--What is the total income from booking_olds for the Grosvenor Hotel today?
SELECT sum(price) FROM room r
JOIN hotel h ON r.hotel_no = h.hotel_no
JOIN booking b ON r.hotel_no = b.hotel_no 
WHERE r.room_no IN (SELECT room_no FROM booking )
and h.name = 'Grosvenor Hotel' AND b.date_from = CURRENT_DATE();

--List the rooms that are currently unoccupied at the Grosvenor Hotel.
SELECT r.* FROM room r
JOIN hotel h ON r.hotel_no = h.hotel_no
JOIN booking_old b ON r.hotel_no = b.hotel_no
WHERE h.name = 'Grosvenor Hotel' AND r.room_no NOT IN (SELECT room_no FROM booking_old);

--What is the lost income from unoccupied rooms at the Grosvenor Hotel?
SELECT sum(price) FROM room r
JOIN hotel h ON r.hotel_no = h.hotel_no
JOIN booking_old b ON r.hotel_no = b.hotel_no
WHERE h.name = 'Grosvenor Hotel' AND r.room_no NOT IN (SELECT room_no FROM booking_old);

--List the number of rooms in each hotel.
SELECT h.name, count(r.room_no) FROM room r
JOIN hotel h ON r.hotel_no = h.hotel_no
GROUP BY h.name;

--List the number of rooms in each hotel in London.
SELECT h.name, count(r.room_no) FROM room r
JOIN hotel h ON r.hotel_no = h.hotel_no
WHERE h.address = 'London'
GROUP BY h.name;

--What is the average number of bookings for each hotel in August?
SELECT h.name, count(b.hotel_no)/count(b.date_from) as average FROM booking_old b
JOIN hotel h ON b.hotel_no = h.hotel_no
WHERE month(b.date_from) = 08
GROUP BY h.name;

--What is the most commonly booked room type for each hotel in London?
SELECT h.name,r.type, count(r.type) FROM hotel h
JOIN room r ON r.hotel_no = h.hotel_no
join booking_old b ON b.hotel_no = r.hotel_no
WHERE h.address = 'London'
GROUP BY h.name, r.type
ORDER BY count(b.hotel_no) DESC;

--What is the lost income from unoccupied rooms at each hotel today
SELECT h.name, sum(r.price) FROM room r
JOIN hotel h ON h.hotel_no = r.hotel_no
JOIN booking b ON b.hotel_no = r.hotel_no
WHERE r.room_no NOT IN (SELECT room_no FROM booking GROUP BY hotel_no) AND b.date_from = CURRENT_DATE()
GROUP BY h.name;
