-- ------------------------------------------------------------------------------------------------------------------
-- Visualizzare, per ogni negozio e per ogni mese, quanti e quali prodotti sono stati
--	richiesti ai diversi fornitori.
-- ------------------------------------------------------------------------------------------------------------------
SELECT month(data_ordine), year(data_ordine), negozio, prodotto, quantita, fornitore
FROM ORDINE
GROUP BY negozio, month(data_ordine), year(data_ordine), prodotto, quantita, fornitore;