CREATE database DB1;

use DB1;

CREATE TABLE TEAM (
  TeamID varchar(25) NOT NULL,
  Team varchar(15) ,
  Continent varchar(15),
  League varchar(15) ,
  Population bigint ,
  PRIMARY KEY (TeamID),
  UNIQUE KEY (Team)
) ;

select * from TEAM;

CREATE TABLE STADIUM (
  SID varchar(25) NOT NULL,
  SName varchar(255) ,
  SCity varchar(255) ,
  SCapacity int,
  PRIMARY KEY (SID),
  UNIQUE KEY (SName)
) ;

SELECT * FROM STADIUM;

CREATE TABLE PLAYER (
  Team varchar(15) NOT NULL,
  TeamID varchar(25) NOT NULL,
   PNo int NOT NULL,
   P_Position char(5) ,
  Pname varchar(50) ,
  BD varchar(200) ,
  Shirt_Name varchar(255),
   Club varchar(255) ,
   Height int,
  Weight int,
  PRIMARY KEY (TeamID,PNo),
  CONSTRAINT `player2` FOREIGN KEY (TeamID) REFERENCES TEAM (TeamID)
) ;


CREATE TABLE GAME (
   GameID VARCHAR(25) NOT NULL,
   Match_Type CHAR(10),
   Match_date varchar(20),
    SID varchar(25) ,
    TeamID_1 varchar(25) NOT NULL ,
    TeamID_2 varchar(25) NOT NULL,
    Team1_Score INT,
    Team2_Score INT,
  PRIMARY KEY (GameID),
  CONSTRAINT `game_1` FOREIGN KEY (SID) REFERENCES STADIUM (SID),
  CONSTRAINT `game_2` FOREIGN KEY (TeamID_1) REFERENCES TEAM (TeamID),
  CONSTRAINT `game_3` FOREIGN KEY (TeamID_2) REFERENCES TEAM (TeamID)
) ;

SELECT * FROM GAME;

CREATE TABLE STARTING_LINEUP (
GameID VARCHAR(25) NOT NULL,
TeamID VARCHAR(25) NOT NULL,
PNo int NOT NULL,
PRIMARY KEY (GameID,TeamID,PNo),
FOREIGN KEY (GameID) REFERENCES GAME(GameID),
 FOREIGN KEY (TeamID,PNo) REFERENCES PLAYER(TeamID,PNo)
   ) 

select * from STARTING_LINEUP;

CREATE TABLE SUBSTITUTIONS (
GameID VARCHAR(25) NOT NULL,
TeamID VARCHAR(25) NOT NULL,
 PNoIn int NOT NULL,
 P_Position char(5) ,
  PNOut int NOT NULL,
  sub_Time  int NOT NULL,
  primary key (GameID,TeamID,PNoIn),
  CONSTRAINT `substituion_ibfk_1` FOREIGN KEY (GameID) REFERENCES GAME (GameID),
  CONSTRAINT `substituion_ibfk_2` FOREIGN KEY (TeamID,PNoIn) REFERENCES PLAYER(TeamID,PNo),
  CONSTRAINT `substituion_ibfk_3` FOREIGN KEY (TeamID,PNOut) REFERENCES PLAYER (TeamID,PNo)/* IMPORTANT*/
) ;

SELECT * FROM SUBSTITUTIONS;

CREATE TABLE GOALS (
GameID VARCHAR(25) NOT NULL,
TeamID VARCHAR(25) NOT NULL,
 PNo int NOT NULL,
 G_Time char(5) ,
 Penalty CHAR(5),
primary key (GameID,TeamID,PNo,G_Time),
  CONSTRAINT `GOALS_ibfk_1` FOREIGN KEY (GameID) REFERENCES `GAME` (GameID),
  CONSTRAINT `GOALS_ibfk_2` FOREIGN KEY (TeamID,PNo) REFERENCES PLAYER(TeamID,PNo)
) ;

SELECT * FROM GOALS;

CREATE TABLE OWN_GOALS (
GameID VARCHAR(25) NOT NULL,
TeamID VARCHAR(25) NOT NULL,
 PNo int NOT NULL,
 OG_Time char(5) ,
 For_TeamID char(5),
 primary key (GameID,TeamID,PNo,OG_Time),
  CONSTRAINT `own_GOALS_ibfk_1` FOREIGN KEY (GameID) REFERENCES GAME (GameID),
  CONSTRAINT `own_GOALS_ibfk_2` FOREIGN KEY (TeamID,PNo) REFERENCES PLAYER(TeamID,PNo),
   CONSTRAINT `own_GOALS_ibfk_3` FOREIGN KEY (For_TeamID) REFERENCES TEAM (TeamID)
) ;

SELECT * FROM OWN_GOALS;

CREATE TABLE CARDS (
GameID VARCHAR(25) NOT NULL,
TeamID VARCHAR(25) NOT NULL,
 PNo int NOT NULL,
 Color CHAR(25),
 C_Time char(5) ,
primary key (GameID,TeamID,PNo,C_Time),
  CONSTRAINT `CARDS_ibfk_1` FOREIGN KEY (GameID) REFERENCES GAME (GameID),
  CONSTRAINT `CARDS_ibfk_2` FOREIGN KEY (TeamID,PNo) REFERENCES PLAYER(TeamID,PNo)
) ;


SELECT * FROM CARDS;




