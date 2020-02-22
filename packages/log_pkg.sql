create or replace  package log_pkg as
procedure log(p_message logs.message%type,p_message_type logs.message_type%type);
end log_pkg;
/
create or replace  package body log_pkg as
procedure log(p_message logs.message%type,p_message_type logs.message_type%type) as
pragma autonomous_transaction;

begin
  
insert into logs values(p_message,p_message_type,sysdate);
commit;

end log;

end log_pkg;
