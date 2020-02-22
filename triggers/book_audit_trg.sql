create or replace trigger book_audit_trg
after update or delete on book for each row 
declare
l_transaction varchar2(10);
 begin
   l_transaction:=case when updating then 'UPDATE'  when deleting then 'DELETE' end;
   insert into audits(table_name,transaction_name,by_user,transaction_date)
   values('BOOK',l_transaction,user,sysdate);
 end;  