select dipendente
from reparti_amministrati
where num_reparti = (select max(num_reparti) from reparti_amministrati);