-- ------------------------------------------------------------------------------------------------------------------
-- 3. Visualizzare, in ordine cronologico, l’elenco dei prodotti acquistati da un dato cliente
-- in un dato negozio nel corso del tempo.
-- ------------------------------------------------------------------------------------------------------------------
select PRODOTTO.nome, PRODOTTO.codice_a_barre, SCONTRINO.data_emissione
from ((PRODOTTO inner join ACQUISTI on codice_a_barre = prodotto) inner join SCONTRINO on scontrino = codice_scontrino) 
	inner join (`FIDELITY CARD` inner join `CLIENTE FEDELE` on cliente = codice_fiscale) on SCONTRINO.fidelity_card = codice_carta
group by codice_fiscale, SCONTRINO.negozio, PRODOTTO.nome, PRODOTTO.codice_a_barre, SCONTRINO.data_emissione
having codice_fiscale = "FHXYNG51D44B549M"
order by SCONTRINO.data_emissione asc