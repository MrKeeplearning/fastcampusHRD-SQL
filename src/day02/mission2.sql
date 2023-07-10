use pokemon;
create table mynewpokemon
(
    number INT,
    name   varchar(20),
    type   varchar(20)
);
insert into mynewpokemon (number, name, type)
values (77, '포니타', '불꽃'),
       (132, '메타몽', '노말'),
       (151, '뮤', '에스퍼');

select * from mynewpokemon;