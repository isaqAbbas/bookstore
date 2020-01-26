create table available_book
(
book_id number references book(id),
store_id number references store(id),
sold number,
sold_date date
);