delimiter |
CREATE function calcola_sconto(c_negozio int, c_prodotto int, c_data date) returns double deterministic
begin

declare c_sconto double;
declare prezzo double;

SELECT prezzo_base INTO prezzo FROM IN_VENDITA INNER JOIN REPARTO ON reparto = codice_reparto WHERE negozio = c_negozio AND prodotto = c_prodotto;

SELECT PRODOTTI_SCONTATI.sconto INTO c_sconto
FROM CAMPAGNA_PROMOZIONALE INNER JOIN PRODOTTI_SCONTATI ON campagna_promozionale = codice_campagna_promozionale
WHERE negozio = c_negozio AND prodotto = c_prodotto AND c_data >= data_inizio AND c_data <= data_fine;

IF(c_sconto IS NOT NULL) THEN
	return prezzo * c_sconto / 100;
ELSE
	return 0.0;
END IF;
END;
|
delimiter ;