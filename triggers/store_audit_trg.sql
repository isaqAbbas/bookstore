CREATE OR REPLACE trigger store_audit_trg
after INSERT OR DELETE OR UPDATE ON store
FOR EACH ROW
DECLARE
  v_user varchar2 (30);
  v_date  varchar2(30);
BEGIN
  SELECT user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') INTO v_user, v_date  FROM dual;
  IF INSERTING THEN
    INSERT INTO  book_store_audit(table_name,by_user,transaction_date,transaction_name)
    VALUES('STORE',v_user,v_date,'Insert');  
  ELSIF DELETING THEN
    INSERT INTO  book_store_audit(table_name,by_user,transaction_date,transaction_name)
    VALUES('STORE',v_user,v_date,'Delete');
  ELSIF UPDATING THEN
    INSERT INTO book_store_audit(table_name,by_user,transaction_date,transaction_name)
    VALUES('STORE',v_user,v_date,'Update');
  END IF;
END;
