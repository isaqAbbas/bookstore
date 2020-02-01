create or replace noneditionable package store_pkg as
procedure ins(p_name store.name%type,p_address store.address%type,p_open_from store.open_from%type,p_open_to store.open_to%type);
procedure upd(p_id store.id%type,p_name store.name%type,p_address store.address%type,p_open_from store.open_from%type,p_open_to store.open_to%type);
procedure del(p_id store.id%type);
end store_pkg;


create or replace noneditionable package body store_pkg as
procedure ins(p_name store.name%type,p_address store.address%type,p_open_from store.open_from%type,p_open_to store.open_to%type) as
begin
insert into store(id,name,address,open_from,open_to) values(store_seq.nextval,p_name,p_address,p_open_from,p_open_to);
commit;
end;
procedure upd(p_id store.id%type,p_name store.name%type,p_address store.address%type,p_open_from store.open_from%type,p_open_to store.open_to%type) as
begin
update store set name=p_name,address=p_address,open_from =p_open_from,open_to=p_open_to where id=p_id;
end;
procedure del(p_id store.id%type) as
begin
delete from store where id=p_id;
end;
end store_pkg;
