-- --------------------------------------------------------------------------------------------------------------------------------------
-- 10. Definire un trigger che effettui un ordine di acquisto ad un fornitore quando la scorta
-- 	di un prodotto è inferiore alla soglia.
-- --------------------------------------------------------------------------------------------------------------------------------------
delimiter |

CREATE TRIGGER sotto_soglia
BEFORE UPDATE ON COLLOCAMENTO
FOR EACH ROW
BEGIN
DECLARE N DOUBLE;
DECLARE F INT;
IF(NEW.quantita < NEW.soglia)
THEN
SELECT negozio INTO N FROM IN_VENDITA INNER JOIN REPARTO ON reparto = codice_reparto  WHERE prodotto = NEW.prodotto;

SELECT FORNITORE.P_IVA INTO F 
FROM (FORNITURA INNER JOIN FORNITORE ON FORNITURA.fornitore = FORNITORE.P_IVA),
	(MAGAZZINO INNER JOIN SCAFFALE ON SCAFFALE.codice_magazzino = MAGAZZINO.codice_magazzino) INNER JOIN RIPIANO ON scaffale = codice_scaffale
WHERE FORNITURA.negozio = MAGAZZINO.negozio AND codice_ripiano = NEW.ripiano;

INSERT INTO ORDINE(negozio, data_ordine, prodotto, quantita, fornitore)
VALUES(N, curdate(), NEW.prodotto, NEW.soglia, F);

END IF;
END;
|
delimiter ;
