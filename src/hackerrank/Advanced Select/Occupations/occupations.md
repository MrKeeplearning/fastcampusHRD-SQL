# Occupations

[문제 바로 가기](https://www.hackerrank.com/challenges/occupations/problem)

<br/>

## 1. 접근 방법

- Doctor, Professor, Singer, Actor 순으로 컬럼을 우선 배치해야 한다.

```mysql
# Query1
select case when Occupation = 'Doctor' then Name else null end as Doctor,
	   case when Occupation = 'Professor ' then Name else null end as Professor,
       case when Occupation = 'Singer' then Name else null end as Singer,
       case when Occupation = 'Actor' then Name else null end as Actor
from OCCUPATIONS;
```

- 위와 같이 컬럼 하나 하나마다 case문을 사용해서 직업이름에 해당되면 자신의 이름을 표기하고 그렇지 않다면 null을 표기하도록 만들었다. 위와 같이 쿼리문을 작성하면 아래와 같은 결과를 출력한다.

```
NULL NULL NULL NULL
NULL NULL NULL Samantha
Julia NULL NULL NULL
NULL NULL NULL NULL
NULL NULL NULL NULL
NULL NULL NULL NULL
Priya NULL NULL NULL
NULL NULL NULL NULL
NULL NULL NULL Jennifer
NULL NULL NULL Ketty
NULL NULL NULL NULL
NULL NULL NULL NULL
NULL NULL Jane NULL
NULL NULL Jenny NULL
NULL NULL Kristeen NULL
NULL NULL Christeen NULL
NULL NULL NULL Eve
Aamina NULL NULL NULL
```

- 위의 결과는 직업의 종류별로 이름이 분류되기는 했지만, 이름이 알파벳 순서로 정렬되지 않은 상태이다.
- **ORDER BY로 정렬하는 것이 해결되지 않을 것 같다면 RANK 함수 사용을 고려해보면 좋다.**
- 직업 별로 파티션을 나눈 다음에 RANK 함수를 사용하면 직업 별로 이름의 RANK가 나오게 된다. 그리고 이 때 나온 RANK를 기반으로 GROUP BY를 수행한다.
- GROUP BY를 수행하면 같은 RANK에 해당하는 이름끼리 같은 레코드에 들어가게 된다.

```mysql
# Query2
select Name,
	   Occupation,
       rank() over(partition by Occupation order by Name asc) as name_order
from OCCUPATIONS;
```

```
Eve Actor 1
Jennifer Actor 2
Ketty Actor 3
Samantha Actor 4
Aamina Doctor 1
Julia Doctor 2
Priya Doctor 3
Ashley Professor 1
Belvet Professor 2
Britney Professor 3
Maria Professor 4
Meera Professor 5
Naomi Professor 6
Priyanka Professor 7
Christeen Singer 1
Jane Singer 2
Jenny Singer 3
Kristeen Singer 4
```

- 위의 쿼리문 대로 실행하면 직업 별로 파티션이 나누어지고, 각 파티션 안에서 이름의 알파벳 순서대로 RANK가 부여된다.
- 최종 결과에서 각 컬럼은 Doctor, Professor, Singer, Actor 순서대로 값이 표기되어야 하기 때문에 처음에 작성했던 Query1을 사용하고 이 때 Query2의 내용을 Query1에서 서브 쿼리로 활용한다.

<br/>

## 2. 최종 결과

```mysql
select min(case when A.Occupation = 'Doctor' then A.Name else null end) as Doctor,
       min(case when A.Occupation = 'Professor' then A.Name else null end) as Professor,
       min(case when A.Occupation = 'Singer' then A.Name else null end) as Singer,
       min(case when A.Occupation = 'Actor' then A.Name else null end) as Actor
from (select Name,
             Occupation,
             rank() over(partition by Occupation order by Name asc) as name_order
      from OCCUPATIONS) A
group by A.name_order;
```

```
Aamina Ashley Christeen Eve 
Julia Belvet Jane Jennifer 
Priya Britney Jenny Ketty 
NULL Maria Kristeen Samantha 
NULL Meera NULL NULL 
NULL Naomi NULL NULL 
NULL Priyanka NULL NULL
```

- Occupation을 partition으로 나누고 이름을 기준으로 RANK를 부여한다.
- 이 때 얻게 된 RANK 정보를 바탕으로 group by를 사용했는데, group by를 사용하려면 min이나 max와 같은 집계함수가 필요하다.
- avg를 하면 완전히 다른 값이 나오기 때문에 원하는 값을 출력하는데 아무런 지장이 없는 min 또는 max를 집계함수로 사용한다. 위에서는 min을 사용했고 max를 사용해도 결과는 동일하다.
- group by에 name_order를 사용했기 때문에 각 직업에서 RANK가 서로 맞는 이름끼리 짝지어 레코드가 완성된다.