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
v_cnt number;
--v_cnt2 number;
begin
/*select count(*) into v_cnt2 from  book where author_id=p_author_id;
if v_cnt2=0 then
insert into book(id,name,author_id,genre_id) values(book_seq.nextval,p_name,p_author_id,p_genre_id); 
else 
  raise_application_error(-20001,'Muellif id/ni tekrar daxil etmek olmaz!'); 
end if;
*/
  select count(*) into v_cnt from  book where name=p_name and author_id=p_author_id;
  if v_cnt=0 then
  insert into book(id,name,author_id,genre_id) values(book_seq.nextval,p_name,p_author_id,p_genre_id);
  else
  raise_application_error(-20001,'Eyni adli kitabi tekrar daxil etmek olmaz!'); 
  end if;
  /*
  if p_genre_id is not  null and p_author_id is not  null then 
    insert into book(id,name,author_id,genre_id) values(book_seq.nextval,p_name,p_author_id,p_genre_id);
    commit;
  else 
    raise_application_error(-20001,'Janr ve ya Muellif daxil edilmayibdir');
  end if;   
  */
end;
--------------------------------------------------------------------------------------------------------------
procedure upd(p_id book.id%type,p_name book.name%type,p_genre_id book.genre_id%type,p_author_id book.author_id%type) as
v_cnt3 number;
begin
/*select count(*) into v_cnt3 from book where name=p_name and author_id=p_author_id;
if v_cnt3=0 then
--if p_id is not null and p_name is not null and p_genre_id is not null and p_author_id  is not null then
update book set name=p_name,genre_id=p_genre_id,author_id=p_author_id  where id=p_id;--her hansisa sutunu saxlaya da bilersen
else 
raise_application_error(-20001,'Janr ve ya Muellif daxil edilmeyib');
--raise_application_error(-20001,'Butun melumatlar daxil edlimeyib!!!');
end if;
commit;*/
---------------

if p_id is  null and p_name is  null and p_genre_id is  null and p_author_id  is  null then
  raise_application_error(-20001,'Butun melumatlar daxil edlimeyib!!!');
end if;

select count(*) into v_cnt3 from book where name=p_name and author_id=p_author_id;
if v_cnt3>0 then 
  raise_application_error(-20001,'Bu kitab movcuddur');
end if;

update book set name=p_name,genre_id=p_genre_id,author_id=p_author_id  where id=p_id;--her hansisa sutunu saxlaya da bilersen
commit;
end;
----------------------------------------------------------------delete pr
procedure del(p_id book.id%type) as
 v_cnt number;
begin
  
if p_id is null  then
raise_application_error(-20001,'ID daxil edilmeyib!!!');
end if;

/*
select count(*) into v_cnt from book where id=p_id;
if v_cnt=0 then 
 raise_application_error(-20001,'Bele id movcud deyil'); 
end if;
*/
delete from book where  id=p_id;
if sql%rowcount=0 then 
  raise_application_error(-20001,'Bele id movcud deyil'); 
end if;
commit;

end;
end book_pkg;
/
