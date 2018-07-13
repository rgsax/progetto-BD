-- --------------------------------------------------------------------------------------------------------------------------------------
-- 11. Definire un processo schedulato che, ogni fine giorno alle 0:00, disabiliti la tessera
-- 	fedeltà dei clienti che non hanno fatto acquisti negli ultimi 2 anni presso il negozio
-- 	che ha rilasciato la tessera.
-- --------------------------------------------------------------------------------------------------------------------------------------
delimiter |
CREATE EVENT disabilita_schede 
ON SCHEDULE EVERY 1 DAY
STARTS “2018-06-01 00:00”
DO
BEGIN
DELETE FROM `FIDELITY CARD`
WHERE datediff(curdate(), data_emissione) >= 2 * 365 AND NOT EXISTS (
	SELECT *
	FROM SCONTRINO
	HAVING fidelity_card = codice_carta AND datediff(curdate(), SCONTRINO.data_emissione) < 2 * 365);
END;
|
delimiter ;