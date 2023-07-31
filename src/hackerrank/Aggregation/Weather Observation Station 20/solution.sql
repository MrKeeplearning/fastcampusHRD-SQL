with ordering as (
    select LAT_N,
           row_number() over(order by LAT_N) as LAT_N_ORDER
    from STATION
)

select round(avg(LAT_N), 4)
from ordering
where LAT_N_ORDER = (select floor(avg(LAT_N_ORDER)) from ordering)
   or LAT_N_ORDER = (select ceil(avg(LAT_N_ORDER)) from ordering)