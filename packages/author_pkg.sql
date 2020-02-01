-- create package specification part
--comment by Zamir
create or replace package author_pkg as
procedure ins(p_name author.name%type);--declare anchored datatype
procedure upt(p_id author.id%type,p_name author.name%type);
procedure del(p_id author.id%type);
end author_pkg;
/
--create procedure body part
create or replace package body author_pkg as
procedure ins(p_name author.name%type) as
begin
insert into author(id,name) values(author_seq.nextval,p_name);
commit;
end;
procedure upt(p_id author.id%type,p_name author.name%type) as
begin
update author set name=p_name where id=p_id;
commit;
end;
procedure del(p_id author.id%type) as
begin
delete from author where id=p_id;
commit;
end;
end author_pkg;
/
