/*
January 15, 2020
Gehad Gad
CUNY MSDS Assignment 3 SQL
*/

/*
An organization grants key-card access to rooms based on groups that key-card holders belong to. You may assume that users below to only one group. Your job is to design the database that supports the key-card system.
There are six users, and four groups. Modesto and Ayine are in group “I.T.” Christopher and Cheong woo are in group “Sales”. 
There are four rooms: “101”, “102”, “Auditorium A”, and “Auditorium B”. Saulat is in group “Administration.” 
Group “Operations” currently doesn’t have any users assigned. I.T. should be able to access Rooms 101 and 102. 
Sales should be able to access Rooms 102 and Auditorium A. Administration does not have access to any rooms. 
Heidy is a new employee, who has not yet been assigned to any group.
*/


CREATE TABLE GroupsNames (
GroupID int not null primary KEY,
GroupName varchar (255)
);

INSERT INTO GroupsNames (GroupID, GroupName) VALUES (1, 'IT');
INSERT INTO GroupsNames (GroupID, GroupName) VALUES (2, 'Sales');
INSERT INTO GroupsNames (GroupID, GroupName) VALUES (3, 'Administration');
INSERT INTO GroupsNames (GroupID, GroupName) VALUES (4, 'Operation');

CREATE TABLE ROOMS (
RoomID INT NOT NULL,
RoomName varchar (255),
GroupID INT,
GroupID2 INT,
Foreign key (GroupID) references GroupsNames (GroupID),
Foreign key (GroupID2) references GroupsNames (GroupID)
);

Alter TABLE ROOMS 
ADD primary key (RoomID);

INSERT INTO ROOMS (RoomID, RoomName, GroupID) VALUES (1, '101',1);
INSERT INTO ROOMS (RoomID, RoomName, GroupID, GroupID2) VALUES (2, '102',1,2); 
INSERT INTO ROOMS (RoomID, RoomName, GroupID) VALUES (3, 'Auditorium A',2);
INSERT INTO ROOMS (RoomID, RoomName, GroupID) VALUES (4, 'Auditorium B', NULL);


CREATE TABLE Users (
UserID INT NOT NULL,
Primary key (UserID),
UserName varchar (255),
RoomID INT,
RoomID2 INT,
FOREIGN KEY (RoomID) REFERENCES ROOMS (RoomID),
FOREIGN KEY (RoomID2) REFERENCES ROOMS (RoomID),
GroupID INT,
FOREIGN KEY (GroupID) REFERENCES GroupsNames (GroupID)
);

INSERT INTO Users (UserID, UserName, GroupID, RoomID, RoomID2) VALUES (1, 'Modesto', 1, 1, 2);
INSERT INTO Users (UserID, UserName, GroupID, RoomID, RoomID2) VALUES (2, 'Ayine', 1, 1, 2);
INSERT INTO Users (UserID, UserName, GroupID, RoomID, RoomID2) VALUES (3, 'Christopher', 2, 2, 3);
INSERT INTO Users (UserID, UserName, GroupID, RoomID, RoomID2) VALUES (4, 'Cheong woo', 2, 2, 3);
INSERT INTO Users (UserID, UserName, GroupID, RoomID) VALUES (5, 'Saulat', 3, NULL);
INSERT INTO Users (UserID, UserName, GroupID, RoomID) VALUES (6, 'Heidy', NULL, NULL);


SELECT * FROM ROOMS;
SELECT * FROM Users;
SELECT * FROM GroupsNames;


#DROP TABLE Users;
#DROP TABLE ROOMS;
#DROP TABLE GroupsNames;

/*
Question 1.
All groups, and the users in each group. 
A group should appear even if there are no users assigned to the group.
*/

SELECT Users.UserName , GroupsNames.GroupName
FROM Users 
RIGHT JOIN GroupsNames ON GroupsNames.GroupID=Users.GroupID;

/*
Question 2.
All rooms, and the groups assigned to each room. 
The rooms should appear even if no groups have been assigned to them.
*/

SELECT GroupsNames.GroupName , ROOMS.RoomName
FROM ROOMS 
LEFT JOIN GroupsNames ON ROOMS.GroupID=GroupsNames.GroupID or ROOMS.GroupID2=GroupsNames.GroupID;


/*
Question 3.
A list of users, the groups that they belong to, and the rooms to which they are assigned. 
This should be sorted alphabetically by user, then by group, then by room.
*/

SELECT Users.UserName , GroupsNames.GroupName ,Rooms.RoomName
FROM Users 
LEFT JOIN (GroupsNames , ROOMS) ON Users.GroupID=GroupsNames.GroupID and ROOMS.GroupID=GroupsNames.GroupID or ROOMS.GroupID2=GroupsNames.GroupID
ORDER BY UserName asc, GroupName asc, RoomName asc;

