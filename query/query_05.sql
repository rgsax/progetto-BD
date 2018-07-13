-- ------------------------------------------------------------------------------------------------------------------
-- 5. Visualizzare il cliente che ha speso di più in tutto il centro commerciale.
-- ------------------------------------------------------------------------------------------------------------------
SELECT codice_fiscale, nome, cognome, spesa
FROM `CLIENTE FEDELE` INNER JOIN spesa_totale ON codice_fiscale = cliente
WHERE spesa = (SELECT max(spesa) FROM spesa_totale);