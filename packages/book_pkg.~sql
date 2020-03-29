create or replace package book_pkg as
procedure ins(p_name book.name%type,p_genre_id book.genre_id%type,p_author_id book.genre_id%type);
procedure upd(p_id book.id%type,p_name book.name%type,p_genre_id book.genre_id%type,p_author_id book.author_id%type);
procedure del(p_id book.id%type);
end book_pkg;
/
create or replace  package body book_pkg as
procedure ins(p_name book.name%type,p_genre_id book.genre_id%type,p_author_id book.genre_id%type) as --------------------ins proc
v_cnt number;

begin
if p_name is null or p_genre_id is null or p_author_id is null then
 log_pkg.log(p_message =>'Kitab adi ,Janr adi  ve ya Muellif adi daxil edilmeyibdir' ,p_message_type =>'critical' );--sherti odemeyen istenilen tranzaksiya loga dusecek 
 raise_application_error(-20001,'Kitab adi ,Janr adi ve ya Muellif adi daxil edilmeyibdir');
end if;

select count(*) into v_cnt from  book where name=p_name and author_id=p_author_id;
if v_cnt>0 then
log_pkg.log(p_message =>'Eyni adli ve eyni muellifli kitabi tekrar daxil etmek olmaz!!!',p_message_type =>'noncritical');
raise_application_error(-20001,'Eyni adli ve eyni muellifli kitabi tekrar daxil etmek olmaz!!!');
end if;

insert into book(id,name,author_id,genre_id) values(book_seq.nextval,p_name,p_author_id,p_genre_id);
commit;
end ins;
------------------------------------------------------------------------------------------------------------------
procedure upd(p_id book.id%type,p_name book.name%type,p_genre_id book.genre_id%type,p_author_id book.author_id%type) as---------upd proc
v_cnt number;
begin
if p_id is  null or p_name is  null or p_genre_id is  null or p_author_id  is  null then--- negative1
log_pkg.log(p_message =>'Kitab adi ,Janr adi  ve ya Muellif adi daxil edilmeyibdir',p_message_type =>'critical' );
raise_application_error(-20001,'Kitab adi ,Janr adi  ve ya Muellif adi daxil edilmeyibdir');
end if;

select count(*) into v_cnt from book where name=p_name and author_id=p_author_id;---negative2
if v_cnt>0 then
log_pkg.log(p_message =>'Yenilenecek olan informasiyalar kohne informasiyalar  ile eynilik teskil edir',p_message_type =>'noncritical' );
raise_application_error(-20001,'Yenilenecek olan informasiya kohne informasiya ile eynilik teskil edir');
end if;

update book set name=p_name,genre_id=p_genre_id,author_id=p_author_id  where id=p_id;--her hansisa sutunu saxlaya da bilersen/positive
commit;
end upd;
------------------------------------------------------------------------------------del proc
procedure del(p_id book.id%type) as
 v_cnt number;
begin

if p_id is null  then
log_pkg.log(p_message =>'ID daxil edilmeyib!!!' ,p_message_type =>'critical' );
raise_application_error(-20001,'ID daxil edilmeyib!!!');
end if;

select count(*) into v_cnt from book where id=p_id;
if v_cnt=0 then
log_pkg.log(p_message =>'Bele ID movcud deyil!!!',p_message_type =>'noncritical' );
raise_application_error(-20001,'Bele ID movcud deyil!!!');
end if;
delete from book where  id=p_id;
commit;
end del;
end book_pkg;
/
