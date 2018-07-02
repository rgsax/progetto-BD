select * 
from `CLIENTE FEDELE`
where codice_fiscale in (
	select codice_fiscale
    from `CLIENTE FEDELE` inner join `FIDELITY CARD` on codice_fiscale = cliente
    group by codice_fiscale
    having count(distinct negozio) = (select count(distinct P_IVA) from NEGOZIO)
	);