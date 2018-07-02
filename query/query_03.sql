select *
from PRODOTTO
where codice_a_barre in(
	select prodotto
    from ACQUISTI inner join SCONTRINO on scontrino = codice_scontrino
    group by fidelity_card, negozio, prodotto
    having fidelity_card = 1
    order by YEAR(data_emissione) ASC, MONTH(data_emissione) ASC, DAY(data_emissione) ASC
);
    