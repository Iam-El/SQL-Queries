

/*Q1.Retrieve the country, height, and names of all the players who hail from the African continent and are
taller than 190 cm . Sort the list by country and their height.*/
select T.Team as Country, P.Height, P.Pname
from TEAM T, PLAYER P 
where P.TeamID = T.TeamID and
T.Continent = 'Africa' and 
P.Height > 190
Order by T.Team, P.Height;


/*Q2 Retrieve the scores of all games played in Group A or B where each team had at least one score.
Each result should list team 1 name, team 1 score, team 2 name, and team 2 score.
result by the match type. */

select g.Match_Type, t1.TeamID, t1.Team as Team1_name, t2.TeamId, t2.Team as Team2_name, g.Team1_Score,  g.Team2_Score from TEAM as t1 
INNER JOIN GAME g on g.TeamID_1 = t1.TeamID
INNER JOIN TEAM t2 on t2.TeamID = g.TeamID_2 
where g.Match_Type IN ('A' , 'B') 
    and (g.Team1_Score >0 and g.Team2_Score >0 ) 
order by g.Match_Type;


/*Q3 For all the players who received red card, retrieve their country, player name,height and weight*/
select P.Team, P.Pname, P.Height, P.Weight FROM PLAYER as P 
where (TeamID, PNo) IN (select TeamID, PNo from CARDS where Color='Red');


/*Q4.What is the name of the player who received the maximum number of yellow cards?
How many yellow cards did he receive, and which country does he come from?*/

select  p1.Team, p1.Pname,Count(*) as Number from PLAYER as p1
INNER JOIN cards c1 on c1.PNo=p1.PNo and c1.TeamID = p1.TeamId 
where (p1.PNo, p1.TeamID)IN
            (select PNo, TeamId from cards as c1 
                        GROUP BY c1.TeamID,c1.PNo 
                        Having (COUNT(*)) =
            (select Max(y.count) 
                        from (select TeamID,PNo, Count(*) as count 
                        from cards where Color = 'Yellow' GROUP BY TeamID,PNo) as y)) 
group by p1.Team, p1.Pname;


/*Q5. Retrieve the names of the teams that scored more than 1 own goals in 1 or more game.
List the number of own goals each of these team scored*/
  select t.TeamID, t.Team, count(G.TeamID) as Number_Of_OWN_Goals from TEAM as t
       inner join OWN_GOALS G 
       on G.TeamID = t.TeamID 
       where (G.TeamID) IN (
              select G.TeamID 
              from OWN_GOALS AS G 
              group by G.TeamID 
              having count(*)>1)
group by t.TeamID, t.Team;
                            
                            
/*Q6.Create a view GAME_INFO that retrieves for each team all that team’s game scores. 
The view should have the following attributes: Team, and for each game that the team has participated 
in(either as TeamID1 or TeamID2) the following information: 
Match Type, MatchDate,StadiumName, SCity, Team1Name, Team1Score, Team2Name, Team2Score.*/

/* The question says we need to display all the matches played by team. We have a total of 64 matches. 
And each match is played by 2 Teams. Which means based on the query we will have 128 results in total for 64 matches*/

CREATE VIEW GAME_INFO
AS Select
g.Match_Type,
g.Match_Date, 
s.SName, 
s.SCity, 
t.Team,
t1.Team as Team1_Name, 
g.Team1_Score,
t2.Team as Team2_Name, 
g.Team2_Score from GAME as g
INNER JOIN STADIUM s on s.SID = g.SID
INNER JOIN TEAM t2 on t2.TeamID = g.TeamID_2
INNER JOIN TEAM t1 on t1.TeamID = g.TeamID_1
INNER JOIN TEAM t on t.TeamID IN (g.TeamID_2, g.TeamID_1) Order BY g.Match_Type;

select * from GAME_INFO;

/*Q7.Write four queries in the view you created :*/
/*Retrieve all game information from GAME_INFO where France played*/
select * from GAME_INFO where Team='France';

/*Retrieve all game information from GAME_INFO where game type is A or X*/
select * from GAME_INFO where Match_Type='A' or Match_Type='X';

/*Retrieve all game information from GAME_INFO where team 1 scored more than 2 goals*/
select * from GAME_INFO where Team1_Score > 2 ;

/*Retrieve all game information from GAME_INFO where the stadium name has Kazan in it.*/
select * from GAME_INFO where SName LIKE '%Kazan%';


/*Write three additional queries on game_info and their results.*/
/* Query 1: Retrieve all game information from GAME_INFO where Team Morocco was involved*/
select * from GAME_INFO where Team1_Name = "Morocco" or Team2_Name = "Morocco";

/* Query 2: Retrieve all game information from GAME_INFO where matches were played between 20th June, 2018 and 25th June, 2018*/
select * from GAME_INFO where Match_Date between '6/20/18' and '6/25/18';

/* Query 3: Retrieve all game information from GAME_INFO where Match C was played in either Samara Arena or Luzhniki Stadium*/
select * from GAME_INFO where Match_Type ="C" and (SName = "Samara Arena" or SName = "Luzhniki Stadium");


/*Q6.Create a view GAME_INFO_NEW that retrieves for each team all that team’s game scores. 
The view should have the following attributes: Team, and for each game that the team has participated 
in(either as TeamID1 or TeamID2) the following information: 
Match Type, MatchDate,StadiumName, SCity, Team1Name, Team1Score, Team2Name, Team2Score.*/

/*We have a GAME INFO_NEW - This query gives us 64 rows if we retrive a team that plays a game in only one column 
we will have 64 results. */ 

create view GAME_INFO_NEW 
  AS select 
  GAME.Match_Type, GAME.Match_date, 
  STADIUM.SName, STADIUM.SCity, 
  t1.Team as Team1_Name, GAME.Team1_Score,
  t2.Team as Team2_Name, GAME.Team2_Score
  from GAME, STADIUM, TEAM t1, TEAM t2
  where GAME.SID = STADIUM.SID
  and t1.TeamID = GAME.TeamID_1
  and t2.TeamID = GAME.TeamID_2
  order by GAME.Match_Type;

select * from GAME_INFO_NEW;

/*Q7.Write four queries in the view you created :*/

/*Retrieve all game information from game_info where France played*/
select * from GAME_INFO_NEW  where Team1_Name='France' or Team2_Name='France';

/*Retrieve all game information from game_info where game type is A or X*/
select * from GAME_INFO_NEW  where Match_Type='A' or Match_Type='X';

/*Retrieve all game information from game_info where team 1 scored more than 2 goals*/
select * from GAME_INFO_NEW  where Team1_Score > 2 ;

/*Retrieve all game information from game_info where the stadium name has Kazan in it.*/
select * from  GAME_INFO_NEW  where SName LIKE '%Kazan%';


/*Write three additional queries on GAME_INFO_NEW and their results.*/
/* Query 1: Retrieve all game information from GAME_INFO_NEW where Team Morocco was involved*/
select * from GAME_INFO_NEW where Team1_Name = "Morocco" or Team2_Name = "Morocco";

/* Query 2: Retrieve all game information from GAME_INFO_NEW where matches were played between 20th June, 2018 and 25th June, 2018*/
select * from GAME_INFO_NEW where Match_Date between '6/20/18' and '6/25/18';

/* Query 3: Retrieve all game information from GAME_INFO_NEW where Match C was played in either Samara Arena or Luzhniki Stadium*/
select * from GAME_INFO_NEW where Match_Type ="C" and (SName = "Samara Arena" or SName = "Luzhniki Stadium");

/*Q.8 1)Retrieve the name of the player and his country who received a yellow card during A Retrieve game. 
Sort the list by country name*/
select P.Team,P.Pname FROM PLAYER as P 
where (TeamID, PNo) IN 
(select TeamID, PNo from CARDS  where Color='Yellow' and GameID IN
(select GameID  from GAME where Match_Type='A' )) order by P.Team;


/*Q8. 2)Retrieve a sorted list of the names of each country/team that played at Least one game In the city of Sochi. */
select  DISTINCT Team, TeamID from TEAM 
where TeamID IN
(select TeamID_1 as TeamId FROM GAME where SID  IN (select SID from STADIUM where SCity='Sochi' ) 
UNION ALL
select TeamID_2 as TeamId FROM GAME where SID  IN (select SID from STADIUM where SCity='Sochi'));


/*Q8. 3)For each player who was substituted In the first 30 minutes of a game, 
retrieve the player name (PlayerOut) and the substitute player’s name (PlayerIn), and the substitution time, as well as the
team name.*/

select ANY_VALUE(p1.Pname) as Player_In, ANY_VALUE(p2.Pname) as Player_Out, t.Team, s.sub_Time from SUBSTITUTIONS s
INNER JOIN Player p1 on p1.PNo = s.PNoIn
INNER JOIN Player p2 on p2.PNo = s.PNOut
INNER JOIN Team t on t.TeamID = s.TeamID
where s.sub_Time <= 30 group by s.sub_Time,t.Team;