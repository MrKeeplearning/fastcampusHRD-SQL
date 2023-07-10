use pokemon;

# 기존 mypokemon 테이블의 type의 데이터 타입이 varchar(20)이었던 것을
# varchar(10)으로 수정한다.
alter table mypokemon
    modify column type varchar(10);

# mypokemon 테이블의 이름을 myoldpokemon 테이블로 이름을 변경한다.
alter table mypokemon rename myoldpokemon;

# 기존 name 칼럼의 이름을 eng_name으로 변경한다.
# 타입을 변경하지 않기 때문에 기존 타입을 그대로 작성한다.
alter table myoldpokemon
    change column name eng_name varchar(20);

# mynewpokemon 테이블의 name 칼럼도 kor_name으로 칼럼 이름을 변경한다.
alter table mynewpokemon
    change column name kor_name varchar(20);