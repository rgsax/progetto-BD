-- --------------------------------------------------------------------------------------------------------------------------------------
-- 8. Visualizzare i clienti che hanno attivato una carta fedeltà in ogni negozio.
-- --------------------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM `CLIENTE FEDELE`
WHERE codice_fiscale IN (
	SELECT codice_fiscale
    FROM `CLIENTE FEDELE` INNER JOIN `FIDELITY CARD` ON codice_fiscale = cliente
    GROUP BY codice_fiscale
    HAVING count(DISTINCT negozio) = (SELECT count(DISTINCT P_IVA) FROM NEGOZIO)
	);