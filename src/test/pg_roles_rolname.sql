select 
    rolname 
from 
    pg_roles 
where 
    rolname in ('stratum'
               ,'stratum_read')
order by rolname;