create view spesa_totale(cliente, spesa) as
select codice_fiscale, sum((prezzo_base - calcola_sconto(SCONTRINO.negozio, ACQUISTI.prodotto, SCONTRINO.data_emissione))* quantita)
from ((SCONTRINO inner join (ACQUISTI inner join IN_VENDITA on ACQUISTI.prodotto = IN_VENDITA.prodotto) on codice_scontrino = scontrino)
	inner join PRODOTTO on codice_a_barre = ACQUISTI.prodotto)
    inner join (`FIDELITY CARD` inner join `CLIENTE FEDELE` on codice_fiscale = `FIDELITY CARD`.cliente) on codice_carta = fidelity_card
group by codice_fiscale;