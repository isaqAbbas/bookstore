create or replace package available_book_pkg as
procedure ins(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type);
procedure del(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type,p_all_books boolean default false);
procedure sell(p_store_id available_book.store_id%type,p_book_id available_book.book_id%Type,p_sell_book_count number);--extra procedure
end available_book_pkg;
/
create or replace package body available_book_pkg as

procedure ins(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type) as
begin

if p_book_id is null or p_store_id is null  then
log_pkg.log(p_message =>'Butun melumatlar daxil edilmelidir!!!',p_message_type =>'critical' );
raise_application_error(-20001,'Butun melumatlar daxil edilmelidir!!!');
end if;
insert into available_book(book_id,store_id,sold) values(p_book_id,p_store_id,0);--when you wish to enter any book to show-case then, sold=0,sold_date is null
commit;
end ins;

procedure del(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type,p_all_books boolean default false) as
v_cnt number;
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
 delete from available_book where sold=0 and book_id=p_book_id and store_id=p_store_id;--remove from exact branch(store)
else
 delete from available_book where sold=0 and book_id=p_book_id;--remove from all branchs
end if; 
commit;
end del;

procedure sell(p_store_id available_book.store_id%type,p_book_id available_book.book_id%Type,p_sell_book_count number) is
 v_cnt number;
 coll tcoll:=tcoll();--after creation nested table collection(tcoll) in another sql  window,intialize it
begin
  select count(*) into v_cnt from available_book where store_id=p_store_id and book_id=p_book_id and sold=0 and sold_date is null;
  if v_cnt<p_sell_book_count then
    raise_application_error(-20001,'Not enough book available in store');
  end if;
  
  select rowid bulk collect into coll from available_book where  sold=0 and sold_date is null  FETCH FIRST p_sell_book_count ROWS ONLY;--bulk collect & select first n rows only
  update available_book  set sold=1,sold_date=sysdate where rowid in (select * from table(coll));--and update the rows which retrived  by collection
  commit;
end sell;

end available_book_pkg;

