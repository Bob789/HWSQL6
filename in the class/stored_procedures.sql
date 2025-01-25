
--def hello_word()-> str:
--	return 'hello world'

-- Procedure - does not return
--create or replace procedure hello_world2()
--language plpgsql as
--$$
--	BEGIN
--		select 1;
--	end;
--$$
--call hello_world2();

-- query plan

create or replace function hello_world() returns varchar
language plpgsql as
$$
	BEGIN
		return CONCAT('hello world! ' , current_timestamp);
	end;
$$

call hello_world2();
-- hello_world()
select * from hello_world()

-- def sp_num(m: float, n: float) -> float
--   return n + m

drop function sp_sum;
create or replace function sp_sum(m double precision,
		n double precision) returns double precision
language plpgsql as
$$
	BEGIN
		return n + m;
	end;
$$

select * from sp_sum(3, 4.9) ;

drop function sp_product_div;
create or replace function sp_product_div(x double precision,
		y double precision,
		out "mul result" double precision,
		out "div result" double precision,
		out "x " double precision,
		out "y " double precision)
language plpgsql as
$$
	BEGIN
		"mul result" = x * y;
		"div result" = x / y;
		"x " = x;
		"y " = y;
		-- return prod_res, div_res . because OUT
	end;
$$

select * from sp_product_div(3, 4.9) ;


create table countries
(
    id   bigserial not null constraint countries_pk
         primary key,
    name text      not null
);
create table movies
(
    id           bigserial                  not null
        constraint movies_pk
            primary key,
    title        text,
    release_date timestamp                  not null,
    price        double precision default 0 not null,
    country_id   bigint
        constraint movies_countries_id_fk
            references countries
);
insert into countries(name) values ('Israel'); -- 1
insert into countries(name) values ('USA'); -- 2
insert into countries(name) values ('JAPAN'); -- 3
insert into countries(name) values ('CANADA'); -- 4
insert into movies (title, release_date, price, country_id)
values ('batman returns', '2020-12-16 20:21:00', 45.5, 3);
insert into movies (title, release_date, price, country_id)
values ('wonder woman', '2018-07-11 08:12:11', 125.5, 3);
insert into movies (title, release_date, price, country_id)
values ('matrix resurrection', '2021-01-03 09:10:11', 38.7, 4);

select * from movies m
join countries c
on m.country_id = c.id;

drop sp_movies_stat;
create or replace function sp_movies_stat(
	out min_price double precision,
	out max_price double precision,
	out avg_price double precision)
	language plpgsql as
	$$
		BEGIN
			select min(price), max(price), avg(price)::numeric(5, 2)
			into min_price, max_price, avg_price
			from movies;
		END;
	$$;
select * from sp_movies_stat();

drop function sp_most_expensive_movie;
CREATE or replace function
sp_most_expensive_movie(OUT movie_name text,
                        OUT movie_price double precision)
language plpgsql AS
    $$
        BEGIN
			select max(price) into movie_price from movies limit 1;

            SELECT title
            into movie_name
            from movies
            where price = movie_price
			limit 1;
        end;
    $$;

select * from sp_most_expensive_movie();










