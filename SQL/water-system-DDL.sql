PRAGMA foreign_keys=on;
BEGIN TRANSACTION;

create table Address (
    id              integer,
    StreetLine1     varchar(40) not null,
    StreetLine2     varchar(40),
    City            varchar(25),
    State           char(2) not null,
    Zip             char(9),
constraint PKAddress primary key(id)
);

create table Meter (
    id          integer,
    Address     integer,
    LastRead    date,
    Owner       integer,
    Rate        decimal(4,3), -- price per cubic foot of water
constraint PKMeter primary key(id),
-- 1-M relationship LocationOf
constraint FKMeterAddress foreign key(Address)
    references Address(id),
-- 1-M relationship OwnedBy
constraint FKMeterOwner foreign key(Owner)
    references Owner(id)
);

create table Reading (
    id          integer,
    DateRead    date not null,
    AmountUsed  decimal(7,3) not null, -- cubic feet of water
    Meter       integer not null,
    Reader      integer not null,
    Bill        integer,
constraint PKReading primary key(id),
-- 1-M relationship IsReadBy
constraint FKReadingMeter foreign key(Meter)
    references Meter(id),
-- 1-M relationship MadeBy
-- FKReadingReader references Person, not Reader, because 
--    there is no Reader table
constraint FKReadingReader foreign key(Reader)
    references Person(id),
-- 1-M relationship IsPartOf
constraint FKReadingBill foreign key(Bill)
    references Bill(id)
)

create table Bill (
    id          integer,
    Owner       integer,
    BillDate    date,
    DueDate     date,
    Amount      decimal(7,2),
    Taxes       decimal(6,2),
    Fees        decimal(6,2),
constraint PKBill primary key(id),
-- 1-M relationship Pays
constraint FKBillOwner foreign key(Owner)
    references Owner(id)
)

-- Generalization hierarchy
-- superclass
create table Person (
    id          integer,
    FirstName   varchar(15) not null,
    LastName    varchar(25) not null,
    Address     integer not null,
constraint PKPerson primary key(id),
-- 1-M relationship AddressOf
constraint FKPersonAddress foreign key(Address)
    references Address(id)
)


-- Make an Owner table because it has its own attribute
-- Generalization hierarchy: subclass
create table Owner (
    id      integer,
    Balance decimal(8,2) not null default 0,
constraint PKOwner primary key(id),
-- because of the generalization hierarchy
constraint FKOwnerPerson foreign key(id)
    references Person(id) 
)

-- No Reader table.  It has no attributes of its own,
-- and it doesn't require any foreign keys.

COMMIT;
