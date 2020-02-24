create or replace package available_book_pkg as
procedure ins(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type);
--procedure upd(p_book_id available_book.book_id%type,p_store_id available_book.store_id%Type,p_sold available_book.sold%Type,p_sold_date available_book.sold_date%Type);
procedure del(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type,p_all_books boolean default false);
procedure sell(p_store_id available_book.store_id%type,p_book_id available_book.book_id%Type,p_sell_book_count number);
end available_book_pkg;
/
create or replace package body available_book_pkg as

procedure ins(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type) as
--v_cnt number;
--v_date date;

begin

if p_book_id is null or p_store_id is null  then
log_pkg.log(p_message =>'Butun melumatlar daxil edilmelidir!!!',p_message_type =>'critical' );
raise_application_error(-20001,'Butun melumatlar daxil edilmelidir!!!');
end if;


/*select count(*) into v_cnt from available_book where book_id =p_book_id and store_id=p_store_id and sold_date=p_sold_date;
if v_cnt>0 then
log_pkg.log(p_message =>'Kitab adi,magazani ve satilma tarixini tekrar daxil etmek olmaz!!!',p_message_type =>'noncritical' );
raise_application_error(-20001,'Kitab adi,magazani ve satilma tarixini tekrar daxil etmek olmaz!!!');
end if;*/


insert into available_book(book_id,store_id,sold) values(p_book_id,p_store_id,0);
commit;
end ins;

/*procedure upd(p_book_id available_book.book_id%type,p_store_id available_book.store_id%Type,p_sold available_book.sold%Type,p_sold_date available_book.sold_date%Type) is
v_cnt number;
begin
if p_book_id is null or p_store_id is null or p_sold is null or p_sold_date is null  then
log_pkg.log(p_message =>'Butun melumatlar daxil edilmelidir!!!',p_message_type =>'critical');
raise_application_error(-20001,'Butun melumatlar daxil edilmelidir!!!');
end if;

select count(*) into v_cnt from available_book where book_id=p_book_id and store_id=p_store_id and sold_date=p_sold_date;
if v_cnt>0 then
log_pkg.log(p_message =>'Bu melumatlar artiq movcuddur!!!',p_message_type =>'noncritical');
raise_application_error(-20001,'Bu melumatlar artiq movcuddur!!!');
end if;
update  available_book set sold=p_sold where book_id=p_book_id and store_id=p_store_id and sold_date=p_sold_date;
commit;
end upd;
*/

procedure del(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type,p_all_books boolean default false) as
v_cnt number;
--v_sold number;
begin
if p_book_id is null or p_store_id is null then
log_pkg.log(p_message =>'Melumatlari daxil edin!!!',p_message_type =>'critical');
raise_application_error(-20001,'Melumatlari daxil edin!!!');
end if;

select count(*) into v_cnt from available_book where book_id=p_book_id and store_id=p_store_id ;
if v_cnt=0 then
log_pkg.log(p_message =>'Bu melumatlar movcud deyil!!!',p_message_type =>'noncritical');
raise_application_error(-20001,'Bu melumatlar movcud deyil!!!');
end if;
if p_all_books!=true then 
 delete from available_book where sold=0 and book_id=p_book_id and store_id=p_store_id;
else
 delete from available_book where sold=0 and book_id=p_book_id;
end if; 
--delete from available_book where sold=0 and book_id=p_book_id and    (false or  p_all_books );
commit;
end del;

procedure sell(p_store_id available_book.store_id%type,p_book_id available_book.book_id%Type,p_sell_book_count number) is
 v_cnt number;
 coll tcoll:=tcoll();
begin
  select count(*) into v_cnt from available_book where store_id=p_store_id and book_id=p_book_id and sold=0 and sold_date is null;
  if v_cnt<p_sell_book_count then
    raise_application_error(-20001,'Not enough book available in store');
  end if;
  
  select rowid bulk collect into coll from available_book where  sold=0 and sold_date is null  FETCH FIRST p_sell_book_count ROWS ONLY;
  update available_book  set sold=1, sold_date=sysdate where rowid in (select * from table(coll));
  commit;
end sell;

end available_book_pkg;

