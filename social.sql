/* Delete the tables if they already exist */
drop table if exists Highschooler;
drop table if exists Friend;
drop table if exists Likes;

/* Create the schema for our tables */
create table Highschooler(ID int, name text, grade int);
create table Friend(ID1 int, ID2 int);
create table Likes(ID1 int, ID2 int);

/* Populate the tables with our data */
insert into Highschooler values (1510, 'Jordan', 9);
insert into Highschooler values (1689, 'Gabriel', 9);
insert into Highschooler values (1381, 'Tiffany', 9);
insert into Highschooler values (1709, 'Cassandra', 9);
insert into Highschooler values (1101, 'Haley', 10);
insert into Highschooler values (1782, 'Andrew', 10);
insert into Highschooler values (1468, 'Kris', 10);
insert into Highschooler values (1641, 'Brittany', 10);
insert into Highschooler values (1247, 'Alexis', 11);
insert into Highschooler values (1316, 'Austin', 11);
insert into Highschooler values (1911, 'Gabriel', 11);
insert into Highschooler values (1501, 'Jessica', 11);
insert into Highschooler values (1304, 'Jordan', 12);
insert into Highschooler values (1025, 'John', 12);
insert into Highschooler values (1934, 'Kyle', 12);
insert into Highschooler values (1661, 'Logan', 12);

insert into Friend values (1510, 1381);
insert into Friend values (1510, 1689);
insert into Friend values (1689, 1709);
insert into Friend values (1381, 1247);
insert into Friend values (1709, 1247);
insert into Friend values (1689, 1782);
insert into Friend values (1782, 1468);
insert into Friend values (1782, 1316);
insert into Friend values (1782, 1304);
insert into Friend values (1468, 1101);
insert into Friend values (1468, 1641);
insert into Friend values (1101, 1641);
insert into Friend values (1247, 1911);
insert into Friend values (1247, 1501);
insert into Friend values (1911, 1501);
insert into Friend values (1501, 1934);
insert into Friend values (1316, 1934);
insert into Friend values (1934, 1304);
insert into Friend values (1304, 1661);
insert into Friend values (1661, 1025);
insert into Friend select ID2, ID1 from Friend;

insert into Likes values(1689, 1709);
insert into Likes values(1709, 1689);
insert into Likes values(1782, 1709);
insert into Likes values(1911, 1247);
insert into Likes values(1247, 1468);
insert into Likes values(1641, 1468);
insert into Likes values(1316, 1304);
insert into Likes values(1501, 1934);
insert into Likes values(1934, 1501);
insert into Likes values(1025, 1101);

/* Core problem set */
	
/* Problem 1
/* Find the names of all students who are friends with someone 
/* named Gabriel. */
select name from Highschooler, (select ID1 from Friend, Highschooler 
where ID2 = ID and name = 'Gabriel') as G where ID = ID1;

/* Problem 2
/* For every student who likes someone 2 or more grades younger 
/* than themselves, return that student's name and grade, and the name and 
/* grade of the student they like. */
select F1.name, F1.grade, F2.name, F2.grade from Likes, Highschooler as F1, 
Highschooler as F2 where Likes.ID1 = F1.ID and Likes.ID2 = F2.ID 
and F1.grade-1 > F2.grade;

/* Problem 3
/* For every pair of students who both like each other, return the name and 
/* grade of both students. Include each pair only once, with the two names 
/* in alphabetical order. */
select H1.name, H1.grade, H2.name, H2.grade from Highschooler as H1, 
Highschooler as H2, (select L1.ID1, L1.ID2 from Likes as L1 join Likes as L2 
where L1.ID1 = L2.ID2 and L1.ID2 = L2.ID1) as L where H1.ID = L.ID1 and 
H2.ID = L.ID2 and H1.name < H2.name;

/* Problem 4
/* Find names and grades of students who only have friends in the same grade. 
/* Return the result sorted by grade, then by name within each grade. */
select H.name, H.grade from Highschooler as H where H.ID not in (select H1.ID 
from Highschooler as H1, Highschooler as H2, Friend as F where F.ID1 = H1.ID 
and F.ID2 = H2.ID and H1.grade <> H2.grade) order by H.grade, H.name;
 
/* Problem 5
/* Find the name and grade of all students who are liked by more than one 
/* other student.  */
select H.name, H.grade from Highschooler as H where H.ID in 
(select L1.ID2 from Likes as L1 join Likes as L2 where L1.ID2 = L2.ID2 and 
L1.ID1 <> L2.ID1);

/* Data Modification Excercises Core Set */

/* Question 1 */
/* It's time for the seniors to graduate. Remove all 12th graders from Highschooler. */
delete from Highschooler where ID in (select ID from Highschooler where grade = 12);

/* Question 2 */
/* If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple. */

	