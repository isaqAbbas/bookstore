--create package specification part
create or replace package book_pkg as
procedure ins(p_name book.name%type,p_genre_id book.genre_id%type,p_author_id book.genre_id%type);
procedure upd(p_id book.id%type,p_name book.name%type,p_genre_id book.genre_id%type,p_author_id book.author_id%type);
procedure del(p_id book.id%type);
end book_pkg;
/
--create package body part
create or replace package body book_pkg as
procedure ins(p_name book.name%type,p_genre_id book.genre_id%type,p_author_id book.genre_id%type) as
begin
insert into book(id,name,author_id,genre_id) values(book_seq.nextval,p_name,p_author_id,p_genre_id);
commit;
end;
procedure upd(p_id book.id%type,p_name book.name%type,p_genre_id book.genre_id%type,p_author_id book.author_id%type) as
begin
update book set name=p_name,genre_id=p_genre_id,author_id=p_author_id  where id=p_id;--her hansisa sutunu saxlaya da bilersen
commit;
end;
procedure del(p_id book.id%type) as
begin
delete from book where  id=p_id;
commit;
end;
end book_pkg;
/
