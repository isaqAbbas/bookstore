--create package specification part
create or replace package genre_pkg as
procedure ins(p_name genre.name%type);
procedure upd(p_id genre.id%type,p_name genre.name%type);
procedure del(p_id genre.id%type);
end  genre_pkg;
/
--create package body part
create or replace package body genre_pkg as
procedure ins(p_name genre.name%type) as
begin
insert into genre(id,name) values(genre_seq.nextval,p_name);
commit;
end;
procedure upd(p_id genre.id%type,p_name genre.name%type) as
begin
update genre set name=p_name where id=p_id;
commit;
end;
procedure del(p_id genre.id%type) as
begin
delete from genre where id=p_id; 
commit;
end;
end genre_pkg;
/
