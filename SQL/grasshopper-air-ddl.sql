-- Turn on foreign-key checking (off by default)
pragma foreign_keys = on;

----------------- Data definition -------------------------

create table if not exists aircraft  (
    PlaneID         char(6), -- registration number
    Model           varchar(20),
    Manufacturer    varchar(20) not null,
    Seats           integer,
constraint PKAircraft primary key(PlaneID)
);

create table if not exists flights (
    FltNum          integer,
    Origin          char(3) not null,
    Destination     char(3) not null,
    -- An actual airline often has multiple legs to a flight.  We'll ignore that.--
    Departs         time not null,
    Arrives         time not null,
    PlaneID         char(6) not null,
    -- Real airlines are a *lot* more flexible in assigning planes to flights.  Again, ignore the complication. --
CONSTRAINT PKFlight primary key(FltNum),
constraint FKFltPlane foreign key(PlaneID)
    references aircraft(PlaneID)
);

create table if not exists passengers (
    PsgrID          integer,
    FirstName       varchar(20),
    LastName        varchar(20) not null,
    Phone           char(10), -- North American phones only!
    StreetAddress   varchar(35),
    StreetLine2     varchar(35),
    City            varchar(25),
    State           char(2),
    Zip             char(9),
constraint PKPsgr primary key(PsgrID)
);

create table if not exists bookings (
    PsgrID          integer not null,
    FltNum           integer not null,
    FltDate         date not null,
    Seat            char(3),
constraint PKBooking primary key(PsgrID, FltNum, FltDate),
constraint FKBookPsgr foreign key(PsgrID) 
    references passengers(PsgrID),
constraint FKBookFlt foreign key(FltNum) 
    references flights(FltNum)
);

------- Data manipulation (initialization, here) ---------

-- INSERT inserts one row of data
-- SQL is case-insensitive
-- Columns names don't have to be in the same order as in CREATE TABLE
-- Column names *do* have to match the order of the values
insert into Aircraft (PlaneID, Manufacturer, Model, Seats) values ('N404CP', 'Cessna', 'Titan 404', 10);
insert into Aircraft (PlaneID, Manufacturer, Model, Seats) values ('N763A', 'Douglas', 'DC-3', 28);
insert into Aircraft (PlaneID, Manufacturer, Model, Seats) values ('N827JS', 'British Aerospace', 'Jetstream 31', 19);
insert into Aircraft (PlaneID, Manufacturer, Model, Seats) values ('N830JS', 'British Aerospace', 'Jetstream 31', 19);


-- Time is represented as a string
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (100, 'ATL', 'GSP', '07:00:00', '08:00:00', 'N827JS');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (101, 'GSP', 'ATL', '09:00:00', '10:00:00', 'N827JS');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (102, 'ATL', 'GSP', '11:00:00', '12:00:00', 'N827JS');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (103, 'GSP', 'ATL', '13:00:00', '14:00:00', 'N827JS');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (104, 'ATL', 'GSP', '15:00:00', '16:00:00', 'N827JS');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (105, 'GSP', 'ATL', '17:00:00', '18:00:00', 'N827JS');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (200, 'AVL', 'GSP', '07:40:00', '08:05:00', 'N404CP');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (201, 'GSP', 'AVL', '09:05:00', '09:30:00', 'N404CP');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (202, 'AVL', 'GSP', '11:40:00', '12:05:00', 'N404CP');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (203, 'GSP', 'AVL', '13:05:00', '13:30:00', 'N404CP');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (204, 'AVL', 'GSP', '15:40:00', '16:05:00', 'N404CP');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (205, 'GSP', 'AVL', '17:05:00', '17:30:00', 'N404CP');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (300, 'CHS', 'GSP', '07:10:00', '08:10:00', 'N830JS');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (301, 'GSP', 'CHS', '09:10:00', '10:10:00', 'N830JS');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (302, 'CHS', 'GSP', '11:10:00', '12:10:00', 'N830JS');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (303, 'GSP', 'CHS', '13:10:00', '14:10:00', 'N830JS');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (304, 'CHS', 'GSP', '15:10:00', '16:10:00', 'N830JS');
insert into Flights (FltNum, Origin, Destination, Departs, Arrives, PlaneID) values (305, 'GSP', 'CHS', '17:10:00', '18:10:00', 'N830JS');


-- Columns with no values are left null
insert into Passengers (PsgrID, FirstName, LastName) values (1, 'Warren', 'Peace');
insert into Passengers (PsgrID, FirstName, LastName) values (2, 'Guy', 'Wire');
insert into Passengers (PsgrID, FirstName, LastName) values (3, 'Sandy', 'Beech');
insert into Passengers (PsgrID, FirstName, LastName) values (4, 'Natalie', 'Dressed');
insert into Passengers (PsgrID, FirstName, LastName) values (5, 'Norman', 'Conquest');
insert into Passengers (PsgrID, FirstName, LastName) values (6, 'Sarah', 'Bellum');
insert into Passengers (PsgrID, FirstName, LastName) values (7, 'Rich', 'Blessing');
insert into Passengers (PsgrID, FirstName, LastName) values (8, 'Eileen', 'Forward');
insert into Passengers (PsgrID, FirstName, LastName) values (9, 'Pete', 'Moss');
insert into Passengers (PsgrID, FirstName, LastName) values (10, 'Bea', 'Strong');
insert into Passengers (PsgrID, FirstName, LastName) values (11, 'Paige', 'Turner');
insert into Passengers (PsgrID, FirstName, LastName) values (12, 'Ruby', 'Yacht');
insert into Passengers (PsgrID, FirstName, LastName) values (13, 'Neal', 'Down');
insert into Passengers (PsgrID, FirstName, LastName) values (14, 'Les', 'Filling');
insert into Passengers (PsgrID, FirstName, LastName) values (15, 'Freida', 'Choose');
insert into Passengers (PsgrID, FirstName, LastName) values (16, 'Evan', 'Essence');
insert into Passengers (PsgrID, FirstName, LastName) values (17, 'Cliff', 'Hanger');
insert into Passengers (PsgrID, FirstName, LastName) values (18, 'Lew', 'Tenant');
insert into Passengers (PsgrID, FirstName, LastName) values (19, 'Emanuel', 'Transmission');
insert into Passengers (PsgrID, FirstName, LastName) values (20, 'Marion', 'Haste');
insert into Passengers (PsgrID, FirstName, LastName) values (21, 'Al', 'Fresco');
insert into Passengers (PsgrID, FirstName, LastName) values (22, 'Anna', 'Conda');
insert into Passengers (PsgrID, FirstName, LastName) values (23, 'Xavier', 'Breath');
insert into Passengers (PsgrID, FirstName, LastName) values (24, 'Otto', 'Bonn');
insert into Passengers (PsgrID, FirstName, LastName) values (25, 'Jerry', 'Atric');
insert into Passengers (PsgrID, FirstName, LastName) values (26, 'Gil', 'O''Teen');
insert into Passengers (PsgrID, FirstName, LastName) values (27, 'Maude', 'Lynn');
insert into Passengers (PsgrID, FirstName, LastName) values (28, 'Rocky', 'Beech');
insert into Passengers (PsgrID, FirstName, LastName) values (29, 'Sonny', 'Down');

-- Dates are represented as a string with an ISO8601 date
insert into Bookings (FltNum, FltDate, PsgrID) values (100, '2021-02-28', 19);
insert into Bookings (FltNum, FltDate, PsgrID) values (100, '2021-03-01', 18);
insert into Bookings (FltNum, FltDate, PsgrID) values (100, '2021-03-04', 5);
insert into Bookings (FltNum, FltDate, PsgrID) values (101, '2021-02-28', 19);
insert into Bookings (FltNum, FltDate, PsgrID) values (101, '2021-03-02', 18);
insert into Bookings (FltNum, FltDate, PsgrID) values (101, '2021-03-04', 24);
insert into Bookings (FltNum, FltDate, PsgrID) values (102, '2021-02-28', 21);
insert into Bookings (FltNum, FltDate, PsgrID) values (102, '2021-03-01', 19);
insert into Bookings (FltNum, FltDate, PsgrID) values (102, '2021-03-02', 15);
insert into Bookings (FltNum, FltDate, PsgrID) values (102, '2021-03-02', 18);
insert into Bookings (FltNum, FltDate, PsgrID) values (102, '2021-03-04', 11);
insert into Bookings (FltNum, FltDate, PsgrID) values (102, '2021-03-04', 20);
insert into Bookings (FltNum, FltDate, PsgrID) values (102, '2021-03-04', 22);
insert into Bookings (FltNum, FltDate, PsgrID) values (102, '2021-03-04', 24);
insert into Bookings (FltNum, FltDate, PsgrID) values (103, '2021-02-28', 21);
insert into Bookings (FltNum, FltDate, PsgrID) values (103, '2021-03-04', 3);
insert into Bookings (FltNum, FltDate, PsgrID) values (104, '2021-03-01', 21);
insert into Bookings (FltNum, FltDate, PsgrID) values (104, '2021-03-04', 3);
insert into Bookings (FltNum, FltDate, PsgrID) values (104, '2021-03-04', 4);
insert into Bookings (FltNum, FltDate, PsgrID) values (105, '2021-02-28', 14);
insert into Bookings (FltNum, FltDate, PsgrID) values (105, '2021-03-02', 1);
insert into Bookings (FltNum, FltDate, PsgrID) values (105, '2021-03-02', 2);
insert into Bookings (FltNum, FltDate, PsgrID) values (105, '2021-03-04', 4);
insert into Bookings (FltNum, FltDate, PsgrID) values (105, '2021-03-04', 9);
insert into Bookings (FltNum, FltDate, PsgrID) values (105, '2021-03-04', 10);
insert into Bookings (FltNum, FltDate, PsgrID) values (105, '2021-03-04', 13);
insert into Bookings (FltNum, FltDate, PsgrID) values (105, '2021-03-04', 15);
insert into Bookings (FltNum, FltDate, PsgrID) values (105, '2021-03-04', 16);
insert into Bookings (FltNum, FltDate, PsgrID) values (200, '2021-02-28', 9);
insert into Bookings (FltNum, FltDate, PsgrID) values (200, '2021-03-02', 23);
insert into Bookings (FltNum, FltDate, PsgrID) values (200, '2021-03-02', 24);
insert into Bookings (FltNum, FltDate, PsgrID) values (201, '2021-03-01', 7);
insert into Bookings (FltNum, FltDate, PsgrID) values (201, '2021-03-01', 9);
insert into Bookings (FltNum, FltDate, PsgrID) values (201, '2021-03-02', 10);
insert into Bookings (FltNum, FltDate, PsgrID) values (201, '2021-03-02', 26);
insert into Bookings (FltNum, FltDate, PsgrID) values (201, '2021-03-04', 3);
insert into Bookings (FltNum, FltDate, PsgrID) values (201, '2021-03-04', 5);
insert into Bookings (FltNum, FltDate, PsgrID) values (202, '2021-03-01', 7);
insert into Bookings (FltNum, FltDate, PsgrID) values (202, '2021-03-02', 6);
insert into Bookings (FltNum, FltDate, PsgrID) values (202, '2021-03-02', 9);
insert into Bookings (FltNum, FltDate, PsgrID) values (202, '2021-03-02', 10);
insert into Bookings (FltNum, FltDate, PsgrID) values (202, '2021-03-04', 3);
insert into Bookings (FltNum, FltDate, PsgrID) values (202, '2021-03-04', 5);
insert into Bookings (FltNum, FltDate, PsgrID) values (202, '2021-03-04', 25);
insert into Bookings (FltNum, FltDate, PsgrID) values (202, '2021-03-04', 26);
insert into Bookings (FltNum, FltDate, PsgrID) values (203, '2021-03-01', 1);
insert into Bookings (FltNum, FltDate, PsgrID) values (203, '2021-03-02', 9);
insert into Bookings (FltNum, FltDate, PsgrID) values (203, '2021-03-02', 13);
insert into Bookings (FltNum, FltDate, PsgrID) values (203, '2021-03-02', 18);
insert into Bookings (FltNum, FltDate, PsgrID) values (203, '2021-03-04', 10);
insert into Bookings (FltNum, FltDate, PsgrID) values (203, '2021-03-04', 15);
insert into Bookings (FltNum, FltDate, PsgrID) values (203, '2021-03-04', 22);
insert into Bookings (FltNum, FltDate, PsgrID) values (203, '2021-03-04', 23);
insert into Bookings (FltNum, FltDate, PsgrID) values (203, '2021-03-04', 24);
insert into Bookings (FltNum, FltDate, PsgrID) values (204, '2021-02-28', 14);
insert into Bookings (FltNum, FltDate, PsgrID) values (204, '2021-03-02', 1);
insert into Bookings (FltNum, FltDate, PsgrID) values (204, '2021-03-02', 18);
insert into Bookings (FltNum, FltDate, PsgrID) values (204, '2021-03-04', 9);
insert into Bookings (FltNum, FltDate, PsgrID) values (204, '2021-03-04', 10);
insert into Bookings (FltNum, FltDate, PsgrID) values (204, '2021-03-04', 13);
insert into Bookings (FltNum, FltDate, PsgrID) values (204, '2021-03-04', 15);
insert into Bookings (FltNum, FltDate, PsgrID) values (204, '2021-03-04', 22);
insert into Bookings (FltNum, FltDate, PsgrID) values (204, '2021-03-04', 23);
insert into Bookings (FltNum, FltDate, PsgrID) values (204, '2021-03-04', 24);
insert into Bookings (FltNum, FltDate, PsgrID) values (205, '2021-03-01', 21);
insert into Bookings (FltNum, FltDate, PsgrID) values (205, '2021-03-02', 6);
insert into Bookings (FltNum, FltDate, PsgrID) values (205, '2021-03-02', 19);
insert into Bookings (FltNum, FltDate, PsgrID) values (205, '2021-03-04', 3);
insert into Bookings (FltNum, FltDate, PsgrID) values (205, '2021-03-04', 20);
insert into Bookings (FltNum, FltDate, PsgrID) values (205, '2021-03-04', 23);
insert into Bookings (FltNum, FltDate, PsgrID) values (205, '2021-03-04', 24);
insert into Bookings (FltNum, FltDate, PsgrID) values (205, '2021-03-04', 25);
insert into Bookings (FltNum, FltDate, PsgrID) values (205, '2021-03-04', 26);
insert into Bookings (FltNum, FltDate, PsgrID) values (205, '2021-03-04', 27);
insert into Bookings (FltNum, FltDate, PsgrID) values (300, '2021-02-28', 1);
insert into Bookings (FltNum, FltDate, PsgrID) values (300, '2021-03-02', 3);
insert into Bookings (FltNum, FltDate, PsgrID) values (301, '2021-02-28', 1);
insert into Bookings (FltNum, FltDate, PsgrID) values (301, '2021-03-04', 23);
insert into Bookings (FltNum, FltDate, PsgrID) values (302, '2021-03-01', 1);
insert into Bookings (FltNum, FltDate, PsgrID) values (302, '2021-03-01', 13);
insert into Bookings (FltNum, FltDate, PsgrID) values (302, '2021-03-04', 23);
insert into Bookings (FltNum, FltDate, PsgrID) values (303, '2021-03-01', 7);
insert into Bookings (FltNum, FltDate, PsgrID) values (303, '2021-03-01', 16);
insert into Bookings (FltNum, FltDate, PsgrID) values (303, '2021-03-02', 6);
insert into Bookings (FltNum, FltDate, PsgrID) values (303, '2021-03-02', 19);
insert into Bookings (FltNum, FltDate, PsgrID) values (303, '2021-03-04', 5);
insert into Bookings (FltNum, FltDate, PsgrID) values (303, '2021-03-04', 11);
insert into Bookings (FltNum, FltDate, PsgrID) values (303, '2021-03-04', 20);
insert into Bookings (FltNum, FltDate, PsgrID) values (303, '2021-03-04', 25);
insert into Bookings (FltNum, FltDate, PsgrID) values (303, '2021-03-04', 26);
insert into Bookings (FltNum, FltDate, PsgrID) values (304, '2021-03-02', 2);
insert into Bookings (FltNum, FltDate, PsgrID) values (304, '2021-03-02', 6);
insert into Bookings (FltNum, FltDate, PsgrID) values (304, '2021-03-02', 7);
insert into Bookings (FltNum, FltDate, PsgrID) values (304, '2021-03-02', 16);
insert into Bookings (FltNum, FltDate, PsgrID) values (304, '2021-03-02', 19);
insert into Bookings (FltNum, FltDate, PsgrID) values (304, '2021-03-04', 5);
insert into Bookings (FltNum, FltDate, PsgrID) values (304, '2021-03-04', 11);
insert into Bookings (FltNum, FltDate, PsgrID) values (304, '2021-03-04', 12);
insert into Bookings (FltNum, FltDate, PsgrID) values (304, '2021-03-04', 20);
insert into Bookings (FltNum, FltDate, PsgrID) values (304, '2021-03-04', 25);
insert into Bookings (FltNum, FltDate, PsgrID) values (304, '2021-03-04', 26);
insert into Bookings (FltNum, FltDate, PsgrID) values (305, '2021-02-28', 8);
insert into Bookings (FltNum, FltDate, PsgrID) values (305, '2021-03-02', 18);
insert into Bookings (FltNum, FltDate, PsgrID) values (305, '2021-03-04', 5);
insert into Bookings (FltNum, FltDate, PsgrID) values (305, '2021-03-04', 7);
insert into Bookings (FltNum, FltDate, PsgrID) values (305, '2021-03-04', 11);
insert into Bookings (FltNum, FltDate, PsgrID) values (305, '2021-03-04', 12);
insert into Bookings (FltNum, FltDate, PsgrID) values (305, '2021-03-04', 17);
insert into Bookings (FltNum, FltDate, PsgrID) values (305, '2021-03-04', 22);
insert into Bookings (FltNum, FltDate, PsgrID) values (305, '2021-03-02', 28);
