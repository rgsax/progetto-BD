create view fid_totali(negozio, num_fid) as
select negozio, count(*)
from `FIDELITY CARD`
group by negozio;