create view reparti_amministrati(dipendente, num_reparti) as
select dipendente, count(distinct reparto)
from RESPONSABILE
group by dipendente;