create or replace  package author_pkg as
procedure ins(p_name author.name%type);--declare anchored datatype
procedure upt(p_id author.id%type,p_name author.name%type);
procedure del(p_id author.id%type);
end author_pkg;
/
create or replace package body author_pkg as
procedure ins(p_name author.name%type) as
v_cnt number;
begin

if p_name is null then--if you want to use only p_name ,then you should define sequence for the p_id.P.S. Now we talk about insert.In GUI it is not useful to use P_ID here.
log_pkg.log(p_message =>'Muellif adi daxil edilmeyib!!!',p_message_type =>'critical');--you should use this message in english language.
raise_application_error(-20001,'Muellif adi daxil edilmeyib!!!');
end if;

select count(*)  into v_cnt from author where name=p_name;--count(*)-returns number of records.
if v_cnt>0  then
log_pkg.log(p_message =>'Muellif adi tekrar daxil edilib!!!',p_message_type =>'noncritical');
raise_application_error(-20001,'Muellif adi tekrar daxil edilib!!!');
end if;

insert into author(id,name) values(author_seq.nextval,p_name);
commit;
end ins;
-----------------------------------------------------------------------------------------------------------
procedure upt(p_id author.id%type,p_name author.name%type) as
v_cnt number;
begin

if p_id is null  or p_name is null then
log_pkg.log(p_message =>'Butun melumatlar daxil edilmeyib!!!' ,p_message_type =>'critical' );
raise_application_error(-20001,'Butun melumatlar daxil edilmeyib!!!');
end if;

select count(*) into v_cnt from author where id=p_id and name=p_name;
if v_cnt>0 then
log_pkg.log(p_message =>'Yenilenecek olan informasiya kohne informasiya ile eynilik teskil edir' ,p_message_type =>'noncritical' );
raise_application_error(-20001,'Yenilenecek olan informasiya kohne informasiya ile eynilik teskil edir');
end if;

update author set name=p_name where id=p_id;
commit;
end upt;
---------------------------------------------------------------------------------------------------------
procedure del(p_id author.id%type) as
v_cnt number;
begin

if p_id is null  then
log_pkg.log(p_message =>'ID daxil edin!!!' ,p_message_type => 'critical');
raise_application_error(-20001,'ID daxil edin!!!');
end if;

select count(*)  into v_cnt from author where id=p_id;
if v_cnt=0 then
log_pkg.log(p_message =>'Bele ID movcud deyil!!!',p_message_type =>'noncritical');
raise_application_error(-20001,'Bele ID movcud deyil!!!');
end if;

delete from author where id=p_id;
commit;
end del;

end author_pkg;
/
