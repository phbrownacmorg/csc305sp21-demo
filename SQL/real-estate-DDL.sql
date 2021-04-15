create table House (
       HomeID	   integer autoincrement,
       StreetAddr  varchar(50) not null,
       City	   varchar(25) not null,
       State	   char(2) not null,

{ etc. }

       SqFt	   integer not null,
       Rented	   boolean not null,
       OwnedBy	   integer
) constraint PKHouse primary key(HomeID),
constraint FKOwner foreign key(OwnerID) references Owner;

create table Listing (
       HouseID	   integer,
       AgentID	   integer,
       Price	   integer not null,
       Commission  fixed(3,1) not null,
       Owner	   integer
) constraint PKListing primary key(HouseID, AgentID),
constraint FKHouse foreign key(HouseID) references House,
constraint FKAgent foreign key(AgentID) references Agent,
constraint FKOwner foreign key(Owner) references Owner;

{ etc. }

