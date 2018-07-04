select negozio
from LOCALE
group by negozio
having count(*) = 1;