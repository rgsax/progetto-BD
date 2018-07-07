select month(data_ordine), year(data_ordine), negozio, prodotto, quantita, fornitore
from ORDINE
group by negozio, month(data_ordine), year(data_ordine), prodotto, quantita, fornitore;