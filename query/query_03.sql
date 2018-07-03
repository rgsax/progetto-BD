select PRODOTTO.nome, SCONTRINO.data_emissione
from ((PRODOTTO inner join ACQUISTI on codice_a_barre = prodotto) inner join SCONTRINO on scontrino = codice_scontrino) 
	inner join (`FIDELITY CARD` inner join `CLIENTE FEDELE` on cliente = codice_fiscale) on SCONTRINO.fidelity_card = codice_carta
group by codice_fiscale, SCONTRINO.negozio, PRODOTTO.nome, SCONTRINO.data_emissione
having codice_fiscale = "grdrcr97h22c710v"
order by SCONTRINO.data_emissione asc