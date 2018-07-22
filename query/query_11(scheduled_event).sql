-- --------------------------------------------------------------------------------------------------------------------------------------
-- 11. Definire un processo schedulato che, ogni fine giorno alle 0:00, disabiliti la tessera
-- 	fedeltà dei clienti che non hanno fatto acquisti negli ultimi 2 anni presso il negozio
-- 	che ha rilasciato la tessera.
-- --------------------------------------------------------------------------------------------------------------------------------------
drop event disabilita_schede;
delimiter |
CREATE EVENT disabilita_schede 
ON SCHEDULE EVERY 1 DAY
STARTS str_to_date("2018,1,1 12,0", "%Y,%m,%d %h,%i")
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