delimiter |
create function calcola_sconto(c_negozio int, c_prodotto int, c_data date) returns double deterministic
begin

declare c_sconto double;
declare prezzo double;

select prezzo_base into prezzo from IN_VENDITA inner join REPARTO on reparto = codice_reparto where negozio = c_negozio and prodotto = c_prodotto;

select PRODOTTI_SCONTATI.sconto into c_sconto
from CAMPAGNA_PROMOZIONALE inner join PRODOTTI_SCONTATI on campagna_promozionale = codice_campagna_promozionale
where negozio = c_negozio and prodotto = c_prodotto and c_data >= data_inizio and c_data <= data_fine;

if(c_sconto is not null) then
	return prezzo * c_sconto / 100;
else
	return 0.0;
end if;
end;
|
delimiter ;