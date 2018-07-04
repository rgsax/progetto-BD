select *
from NEGOZIO inner join fid_totali on P_IVA = negozio
where num_fid < (select avg(num_fid) from fid_totali);