--bize json veribler hardaki choxlu sayda kitab melumatlari var ve biz bu melumatlari book cedveline elave etmaliyik
--jsn faylda bize avtor ve genre ,book adlari gonderilir. 
--Bu adlar bizde ola da biler olmayada . Yani adiyati avtor ve genre cedvellerinde jsonda gonderilen bu adlarin olub  olamdighini yoxlamaq mutleqdir
--Bunun uchun bize her 2 ki paketda adlarin olub olmadighinini yoxlayan funksiyaklaer elave etmak garakdir.
--Eger funksiya adiyyati adi cedvelde tapmadisa o zaman bu haqda melumat qayatrmalidir
--json melumatlari uzre kitablarin kutlevi books cedveline daxil edilme prosesi zamani jsonda olan her hansi bir muellif ve ya janr adi cedvellerde movcud 
--olmazsa bu zaman 2 variant hell yolu movcuddur .1) ya biz hemin anda xeta verirrik prosesi qiririq. ++2. ya da hemin anda movcud olmayan melumatlari(avtor ve ya janrd adi)
--adiyati cedvellere elave etmak


create or replace type tbooks as object (
book_name varchar2(100), author_name varchar2(100),genre_name varchar2(100)
);

create type tcollbooks is table of tbooks;

--
declare
 --type tbooks is record(book_name book.name%type, author_name author.name%type,genre_name genre.name%Type);
 --type tcollbooks is table of tbooks index by pls_integer;
 collbooks tcollbooks:=tcollbooks();
 v_json varchar2(4000):= '{"BOOKS":[{"book_name":"Idyot","author_name":"F.Dostoyevski","genre_name":"roman"}]}';
 
begin
  for i in (with t as (select v_json as data from dual) 
              select a.* from t,json_table(data,'$.BOOKS[*]'
                                COLUMNS(book_name varchar2(100) path '$.book_name',
                                        author_name varchar2(100) path '$.author_name',
                                        genre_name varchar2(100) path '$.genre_name'))a) loop
    --coleection doldurulur
    collbooks.extend;
    collbooks(collbooks.last):=tbooks(i.book_name,i.author_name,i.genre_name);
  end loop;               
 --dolu collectionla ish gormek
 for i in 1..collbooks.count loop
   --json da olan avtor adinin avtor cedvelinde olub olmadighini yoxlayiriq. eger yoxdursa cedvele elave edirik
   if author_pkg.isexists(p_name => collbooks(i).author_name)=false then 
      author_pkg.ins(p_name => collbooks(i).author_name);
   end if;
   --json da olan genre  adinin genre  cedvelinde olub olmadighini yoxlayiriq. eger yoxdursa cedvele elave edirik
   if genre_pkg.isexists(p_name => collbooks(i).genre_name)=false then 
      genre_pkg.ins(p_name => collbooks(i).genre_name);
   end if;
   
   --eger melumatlar her 2 cedvelde varsa o zaman book cedvelinde avtor ve genre melumatlarin id lerini saxlandighindan, avtor ve genre adlarina gore
   --onlarin id lerini qaytaran funkisyalari tetbiq edarak insert yazmaq lazimdir
  insert into book(id,
                   name,
                   author_id,
                   genre_id)
              values(book_seq.nextval,collbooks(i).book_name,author_pkg.getid(collbooks(i).author_name),genre_pkg.getid(collbooks(i).genre_name));
  commit;       
 end loop;
end;


select * from author;
select * from genre;
select * from book;