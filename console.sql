
create database library;

CREATE TABLE author
(
    id        SERIAL,
    firstname varchar(128) NOT NULL,
    lastname  varchar(128) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE books
(
    id         SERIAL,
    name       varchar(128) NOT NULL,
    date       date         not null,
    page_count int,
    author_id  INT REFERENCES author (id) on delete cascade,
    PRIMARY KEY (id)
);
INSERT INTO author(firstname, lastname)
VALUES ('Александр', 'Пушкин'),
       ('Сергей', 'Есенин'),
       ('Михаил', 'Булгаков');

INSERT INTO books(name, date, page_count, author_id)
VALUES ('книга0', '2019.01.01', 123, 1),
       ('книга1', '2020.11.02', 45, 2),
       ('книга2', '2018.02.03', 90, 1),
       ('книга3', '1928.09.12', 78, 2),
       ('книга4', '1997.12.08', 235, 1),
       ('книга5', '1992.02.28', 74, 3),
       ('книга6', '1995.01.25', 197, 3),
       ('книга7', '1965.05.19', 155, 2),
       ('книга8', '2005.06.14', 81, 3),
       ('книга9', '2000.03.30', 25, 1);

select name, date, lastname, firstname
from books, author
where author_id = author.id
order by date desc;

select name
from books, author
WHERE author_id = author.id
  and lastname = 'Пушкин'
  and firstname = 'Александр';

SELECT b.name, b.page_count FROM books b
where b.page_count>(
    SELECT AVG(page_count) FROM books);

select name,page_count, date from books
order by date LIMIT 3;

UPDATE books
SET date = CURRENT_DATE
WHERE page_count IN(select min(page_count)from books
                    group by author_id);

DELETE FROM author
WHERE author.id = (
    select author_id from  books
    where page_count = (
        select max(page_count) from books));



