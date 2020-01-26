create table book
(
id number primary key,
name varchar2(50),
author_id number references author(id),
genre_id  number references  genre(id)
);