create or replace package available_book_pkg as 
procedure ins(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type,p_sold available_book.sold%type,p_sold_date available_book.sold_date%type);
procedure upd(p_book_id available_book.book_id%type,p_store_id available_book.store_id%Type,
              p_store_id_new  available_book.store_id%type,p_sold available_book.sold%Type,p_sold_date available_book.sold_date%Type);
end available_book_pkg;

create or replace package body available_book_pkg as 
procedure ins(p_book_id available_book.book_id%type,p_store_id available_book.store_id%type,p_sold available_book.sold%type,p_sold_date available_book.sold_date%type) as
begin
insert into available_book values(p_book_id,p_store_id,p_sold,p_sold_date);
end;
procedure upd(p_book_id available_book.book_id%type,p_store_id available_book.store_id%Type,
              p_store_id_new  available_book.store_id%type,p_sold available_book.sold%Type,p_sold_date available_book.sold_date%Type) is 
begin
  update  available_book set  store_id=p_store_id_new,sold=p_sold,sold_date=p_sold_date where book_id=p_book_id and store_id=p_store_id;
  commit; 
end;             
end available_book_pkg;


