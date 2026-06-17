-- Display all passenger names from the Passenger table.
SELECT name FROM Passenger;

-- Display all company names from the Company table.
SELECT name FROM Company;

-- Display all trips departing from Moscow.
SELECT * FROM Trip
WHERE town_from = 'Moscow'; 

-- Display passenger names ending with 'man'
SELECT name FROM Passenger
WHERE name LIKE '%man';

-- Count total trips performed by TU-134 aircraft.
SELECT COUNT(*) AS count FROM Trip
WHERE plane = 'TU-134';

-- Display companies that operated Boeing flights.
SELECT DISTINCT Company.name FROM Company
JOIN Trip ON Company.id = Trip.company
WHERE Trip.plane = 'Boeing';

-- Display all aircraft models that can fly to Moscow.
SELECT DISTINCT plane FROM Trip
WHERE town_to = 'Moscow';

-- Display destinations and flight times from Paris.
SELECT town_to, TIMEDIFF(time_in, time_out) AS flight_time FROM Trip
WHERE town_from = 'Paris';

-- Display companies operating flights from Vladivostok.
SELECT DISTINCT name FROM Company
JOIN Trip ON Company.id = Trip.company
WHERE Trip.town_from = 'Vladivostok'

-- Display all flights departing between 10:00 and 14:00.
SELECT * FROM Trip
WHERE TIME(time_out) BETWEEN '10:00:00' AND '14:00:00';

-- Display passengers with the longest full name.
SELECT name FROM Passenger
WHERE LENGTH(name) = (SELECT MAX(LENGTH(name)) FROM Passenger);

-- Display all trip IDs and the number of passengers on each.
SELECT Trip.id, COUNT(Pass_in_trip.id) AS count FROM Trip
LEFT JOIN Pass_in_trip ON Trip.id = Pass_in_trip.trip
GROUP BY Trip.id;

-- Display passenger names that have full namesakes (more than one passenger with the same name).
SELECT name FROM Passenger
GROUP BY name
HAVING COUNT(*) > 1;

-- Display all cities where Bruce Willis has flown.
SELECT DISTINCT town_to FROM Trip
WHERE id IN (SELECT trip FROM Pass_in_trip WHERE passenger IN (SELECT id FROM Passenger WHERE name = 'Bruce Willis'));

-- Display Steve Martin's passenger ID and arrival time in London.
SELECT Passenger.id, Trip.time_in FROM Passenger
JOIN Pass_in_trip ON Passenger.id = Pass_in_trip.passenger
JOIN Trip ON Pass_in_trip.trip = Trip.id
WHERE Passenger.name = 'Steve Martin' AND Trip.town_to = 'London';

-- Display passenger ID, name, and number of flights (only passengers with at least one flight), sorted by flight count descending and name ascending.
SELECT Passenger.id, Passenger.name, COUNT(Pass_in_trip.trip) AS count FROM Passenger 
JOIN Pass_in_trip ON Passenger.id = Pass_in_trip.passenger
GROUP BY Passenger.id, Passenger.name
ORDER BY count DESC, Passenger.name ASC;

-- Display family members who made purchases in 2005, showing their name, status, and total spending.
SELECT FamilyMembers.member_name, FamilyMembers.status, SUM (Payments.amount * Payments.unit_price) AS costs FROM FamilyMembers
JOIN Payments ON FamilyMembers.member_id = Payments.family_member WHERE YEAR (Payments.date) = 2005
GROUP BY FamilyMembers.member_id, FamilyMembers.member_name, FamilyMembers.status
HAVING SUM(Payments.amount * Payments.unit_price) > 0;

-- Display the name(s) of the oldest family member(s).
SELECT FamilyMembers.member_name FROM FamilyMembers
WHERE FamilyMembers.birthday = (SELECT MIN(FamilyMembers.birthday) FROM FamilyMembers);

-- Display the status(es) of family members who bought potato.
SELECT DISTINCT FamilyMembers.status FROM FamilyMembers
JOIN Payments ON FamilyMembers.member_id = Payments.family_member
JOIN Goods ON Payments.good = Goods.good_id
WHERE Goods.good_name = 'potato';

-- Display status, name, and total spending on entertainment for each family member.
SELECT FamilyMembers.status, FamilyMembers.member_name, SUM(Payments.amount * Payments.unit_price) AS costs FROM FamilyMembers
JOIN Payments ON FamilyMembers.member_id = Payments.family_member
JOIN Goods ON Payments.good = Goods.good_id
JOIN GoodTypes ON Goods.type = GoodTypes.good_type_id
WHERE GoodTypes.good_type_name = 'entertainment'
GROUP BY FamilyMembers.status, FamilyMembers.member_name, FamilyMembers.member_id

-- Display goods that were purchased more than once.
SELECT Goods.good_name FROM Goods
JOIN Payments ON Goods.good_id = Payments.good
GROUP BY Goods.good_id, Goods.good_name
HAVING COUNT(Payments.payment_id) > 1;

-- Display the names of all mothers.
SELECT FamilyMembers.member_name FROM FamilyMembers
WHERE FamilyMembers.status = 'mother';

-- Display the name and price of the most expensive delicacy.
SELECT Goods.good_name, Payments.unit_price FROM Goods
JOIN Payments ON Goods.good_id = Payments.good
JOIN GoodTypes ON Goods.type = GoodTypes.good_type_id
WHERE GoodTypes.good_type_name = 'delicacies'
ORDER BY Payments.unit_price DESC
LIMIT 1;

-- Display family members' names and total spending for June 2005.
SELECT FamilyMembers.member_name, SUM (Payments.amount * Payments.unit_price) AS costs FROM FamilyMembers
JOIN Payments ON FamilyMembers.member_id = Payments.family_member
WHERE YEAR(Payments.date) = 2005 AND MONTH(Payments.date) = 06
GROUP BY FamilyMembers.member_id, FamilyMembers.member_name;

-- Display goods that were not purchased in 2005.
SELECT Goods.good_name FROM Goods
WHERE Goods.good_id NOT IN (SELECT DISTINCT Payments.good FROM Payments
WHERE YEAR(Payments.date) = 2005);

-- Display product type groups that were not purchased in 2005.
SELECT GoodTypes.good_type_name FROM GoodTypes
WHERE GoodTypes.good_type_id NOT IN (SELECT DISTINCT Goods.type FROM Payments
JOIN Goods ON Payments.good = Goods.good_id
WHERE YEAR(Payments.date) = 2005);

-- Display product type groups and total spending on each in 2005.
SELECT GoodTypes.good_type_name, SUM (Payments.amount * Payments.unit_price) AS costs FROM GoodTypes
JOIN Goods ON GoodTypes.good_type_id = Goods.type
JOIN Payments ON Goods.good_id = Payments.good
WHERE YEAR(Payments.date) = 2005
GROUP BY GoodTypes.good_type_id, GoodTypes.good_type_name
HAVING SUM(Payments.amount * Payments.unit_price) > 0;

-- Count flights from Rostov to Moscow.
SELECT COUNT(*) AS count FROM Trip
WHERE Trip.town_from = 'Rostov' AND Trip.town_to = 'Moscow';

-- Display names of passengers who flew to Moscow on a TU-134 aircraft
SELECT DISTINCT Passenger.name FROM Passenger
JOIN Pass_in_trip ON Passenger.id = Pass_in_trip.passenger
JOIN Trip ON Pass_in_trip.trip = Trip.id
WHERE Trip.town_to = 'Moscow' AND Trip.plane = 'TU-134'

-- Display trip ID and number of occupied seats, sorted by occupancy descending.
SELECT Pass_in_trip.trip, COUNT(*) AS count FROM Pass_in_trip
GROUP BY Pass_in_trip.trip
ORDER BY count DESC;

-- Display all family members with the surname Quincey.
SELECT * FROM FamilyMembers
WHERE FamilyMembers.member_name LIKE '%Quincey%';

-- Display the average age of family members, rounded down to the nearest whole number
SELECT FLOOR(AVG(YEAR(CURDATE()) - YEAR(birthday))) AS age FROM FamilyMembers

-- Display the average price of red and black caviar.
SELECT AVG(Payments.unit_price) AS cost FROM Payments
JOIN Goods ON Payments.good = Goods.good_id
WHERE Goods.good_name = 'red caviar' OR Goods.good_name = 'black caviar';

-- Count the number of 10th grade classes.
SELECT COUNT(*) AS count FROM Class
WHERE Class.name = 10;

-- Count the number of distinct classrooms used on September 2, 2019.
SELECT COUNT (DISTINCT Schedule.classroom) AS count FROM Schedule
WHERE Schedule.date = '2019-09-02'

-- Display all students living on Pushkina Street.
SELECT * FROM Student
WHERE Student.address LIKE '%Pushkina%';

-- Display the age of the youngest student.
SELECT MIN(TIMESTAMPDIFF(YEAR, Student.birthday, CURDATE())) AS year FROM Student;

-- Count students with the first name Anna.
SELECT COUNT(*) AS count FROM Student
WHERE Student.first_name = 'Anna'

-- Count students in class 10 B.
SELECT COUNT(*)AS count FROM Student_in_class
JOIN Class ON Student_in_class.class = Class.id
WHERE Class.name = '10 B'

-- Display subjects taught by teacher Romashkin P.P.
SELECT DISTINCT Subject.name AS subjects FROM Teacher
JOIN Schedule ON Teacher.id = Schedule.teacher
JOIN Subject ON Schedule.subject = Subject.id
WHERE Teacher.last_name = 'Romashkin' AND Teacher.first_name LIKE 'P%' AND Teacher.middle_name LIKE 'P%'