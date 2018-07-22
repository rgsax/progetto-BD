CREATE VIEW spesa_totale(cliente, spesa) AS
SELECT codice_fiscale, sum((prezzo_base - prezzo_base * `FIDELITY CARD`.sconto - calcola_sconto(SCONTRINO.negozio, ACQUISTI.prodotto, SCONTRINO.data_emissione))* quantita)
FROM ((SCONTRINO INNER JOIN (ACQUISTI INNER JOIN IN_VENDITA ON ACQUISTI.prodotto = IN_VENDITA.prodotto) ON codice_scontrino = scontrino)
	INNER JOIN PRODOTTO ON codice_a_barre = ACQUISTI.prodotto)
    INNER JOIN (`FIDELITY CARD` INNER JOIN `CLIENTE FEDELE` ON codice_fiscale = `FIDELITY CARD`.cliente) ON codice_carta = fidelity_card
GROUP BY codice_fiscale;