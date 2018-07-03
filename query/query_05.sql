select codice_fiscale, nome, cognome, spesa
from `CLIENTE FEDELE` inner join spesa_totale on codice_fiscale = cliente
where spesa = (select max(spesa) from spesa_totale);