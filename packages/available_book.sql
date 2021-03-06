create or replace package available_book_pkg as 
procedure ins(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type,p_sold available_book.sold%type,p_sold_date available_book.sold_date%type);
procedure upd(p_book_id available_book.book_id%type,p_store_id available_book.store_id%Type,p_sold available_book.sold%Type,p_sold_date available_book.sold_date%Type);
procedure del(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type,p_sold_date available_book.sold_date%type);
end available_book_pkg;
------------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace package body available_book_pkg as
 
procedure ins(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type,p_sold available_book.sold%type,p_sold_date available_book.sold_date%type) as
v_cnt number;

begin

if p_book_id is null or p_store_id is null or p_sold is null or p_sold_date is null  then
raise_application_error(-20001,'Butun melumatlar daxil edilmelidir!!!'); 
end if;
select count(*) into v_cnt from available_book where book_id =p_book_id and store_id=p_store_id and sold_date=p_sold_date;
if v_cnt>0 then
raise_application_error(-20001,'Kitab adi,magazani ve satilma tarixini tekrar daxil etmek olmaz!!!');  
end if;
  
insert into available_book(book_id,store_id,sold,sold_date) values(p_book_id,p_store_id,p_sold,p_sold_date);
commit;
end ins;

procedure upd(p_book_id available_book.book_id%type,p_store_id available_book.store_id%Type,p_sold available_book.sold%Type,p_sold_date available_book.sold_date%Type) is 
v_cnt number;
begin
if p_book_id is null or p_store_id is null or p_sold is null or p_sold_date is null  then
raise_application_error(-20001,'Butun melumatlar daxil edilmelidir!!!');  
end if;

select count(*) into v_cnt from available_book where book_id=p_book_id and store_id=p_store_id and sold_date=p_sold_date;
if v_cnt>0 then
raise_application_error(-20001,'Bu melumatlar artiq movcuddur!!!');
end if;
update  available_book set sold=p_sold where book_id=p_book_id and store_id=p_store_id and sold_date=p_sold_date;
commit; 
end upd;

procedure del(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type,p_sold_date available_book.sold_date%type) as
v_cnt number; 

begin
if p_book_id is null or p_store_id is null or p_sold_date is null then
raise_application_error(-20001,'Melumatlari daxil edin!!!');
end if;

select count(*) into v_cnt from available_book where book_id=p_book_id and store_id=p_store_id and   sold_date=p_sold_date;
if v_cnt=0 then
raise_application_error(-20001,'Bu melumatlar movcud deyil!!!');
end if; 
delete from available_book where book_id=p_book_id and store_id=p_store_id and sold_date=p_sold_date; 
commit;
end del; 
            
end available_book_pkg;


