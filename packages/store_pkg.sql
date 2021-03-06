create or replace  package store_pkg as
procedure ins(p_name store.name%type,p_address store.address%type,p_open_from store.open_from%type,p_open_to store.open_to%type);
procedure upd(p_id store.id%type,p_name store.name%type,p_address store.address%type,p_open_from store.open_from%type,p_open_to store.open_to%type);
procedure del(p_id store.id%type);
end store_pkg;
/
create or replace  package body store_pkg as
procedure ins(p_name store.name%type,p_address store.address%type,p_open_from store.open_from%type,p_open_to store.open_to%type) as--ins proc
v_cnt number;
begin

if p_name is null or p_address is null or p_open_from is null or p_open_to is null then
log_pkg.log(p_message =>'Butun melumatlar daxil edilmelidir!!!',p_message_type =>'critical');
raise_application_error(-20001,'Butun melumatlar daxil edilmelidir!!!');
end if;

select count(*) into v_cnt from store where name=p_name and address=p_address;
if v_cnt>0 then
log_pkg.log(p_message =>'Magaza adi ve unvanini tekrar daxil etmek olmaz!!!',p_message_type =>'noncritical' );
raise_application_error(-20001,'Magaza adi ve unvanini tekrar daxil etmek olmaz!!!');
end if;

insert into store(id,name,address,open_from,open_to) values(store_seq.nextval,p_name,p_address,p_open_from,p_open_to);
commit;
end ins;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
procedure upd(p_id store.id%type,p_name store.name%type,p_address store.address%type,p_open_from store.open_from%type,p_open_to store.open_to%type) as--upd proc
v_cnt number;
begin

if p_name is null or p_address is null or p_open_from is null or p_open_to is null then
log_pkg.log(p_message =>'Butun melumatlar daxil edilmelidir!!!',p_message_type =>'critical');
raise_application_error(-20001,'Butun melumatlar daxil edilmelidir!!!');
end if;

select count(*) into v_cnt from store where name=p_name and address=p_address;
if v_cnt>0 then
log_pkg.log(p_message =>'Yenilenecek olan informasiyalar kohne informasiyalar  ile eynilik teskil edir' ,p_message_type => 'noncritical');
raise_application_error(-20001,'Yenilenecek olan informasiyalar kohne informasiyalar  ile eynilik teskil edir');
end if;

update store set name=p_name,address=p_address,open_from =p_open_from,open_to=p_open_to where id=p_id;
commit;
end upd;
-----------------------------------------------------------------------------------------------------------------------
procedure del(p_id store.id%type) as--del proc
v_cnt number;
begin

if p_id is null  then
log_pkg.log(p_message =>'ID daxil edin!!!',p_message_type =>'critical');
raise_application_error(-20001,'ID daxil edin!!!');
end if;

select count(*) into v_cnt from store where id=p_id;
if v_cnt=0 then
log_pkg.log(p_message =>'Bele bir ID movcud deyil!!!',p_message_type =>'noncritical');
raise_application_error(-20001,'Bele bir ID movcud deyil!!!');
end if;

delete from store where id=p_id;
commit;
end del;

end store_pkg;
/
