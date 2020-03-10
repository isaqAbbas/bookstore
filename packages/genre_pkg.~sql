--create package specification part
create or replace package genre_pkg as
procedure ins(p_name genre.name%type);
procedure upd(p_id genre.id%type,p_name genre.name%type);
procedure del(p_id genre.id%type);
end  genre_pkg;
/
--create package body part
create or replace package body genre_pkg as
procedure ins(p_name genre.name%type) as--ins proc
v_cnt number;
begin
  
if p_name is null then
raise_application_error(-20001,'Janr daxil edilmeyib!!!'); 
end if;

select count(*) into v_cnt from genre where name=p_name;
if v_cnt>0 then
raise_application_error(-20001,'Eyni janri tekrar daxil etmek olmaz!!!'); 
end if;

insert into genre(id,name) values(genre_seq.nextval,p_name);
commit;
end ins;

procedure upd(p_id genre.id%type,p_name genre.name%type) as--upd proc
v_cnt number;
begin
  
if p_id is null or  p_name is null then
raise_application_error(-20001,'Butun melumatlar daxil edilmeyib!!!'); 
end if;  

select count(*) into v_cnt from genre where name=p_name ;
if v_cnt>0 then
raise_application_error(-20001,'Melumati tekrar daxil etmek olmaz!!!');
end if;

update genre set name=p_name where id=p_id and name=p_name;
commit;
end upd;

procedure del(p_id genre.id%type) as--del proc
 v_cnt number; 
begin
  if p_id is null then
  raise_application_error(-20001,'ID daxil edin!!!'); 
  end if;
  
select count(*) into v_cnt from book where id=p_id;---bele bir ID yoxsa
if v_cnt=0 then 
raise_application_error(-20001,'Bele ID movcud deyil!!!'); 
end if;

delete from genre where id=p_id; 
commit;
end del;

end genre_pkg;
/
