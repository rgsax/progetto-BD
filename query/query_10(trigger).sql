delimiter |

create trigger sotto_soglia
before update on COLLOCAMENTO
for each row
begin
declare N double;
declare F int;
if(NEW.quantita < NEW.soglia)
then
select negozio into N from IN_VENDITA inner join REPARTO on reparto = codice_reparto  where prodotto = NEW.prodotto;

select FORNITORE.P_IVA into F 
from (FORNITURA inner join FORNITORE on FORNITURA.fornitore = FORNITORE.P_IVA),
	(MAGAZZINO inner join SCAFFALE on SCAFFALE.codice_magazzino = MAGAZZINO.codice_magazzino) inner join RIPIANO on scaffale = codice_scaffale
where FORNITURA.negozio = MAGAZZINO.negozio and codice_ripiano = NEW.ripiano;

insert into ORDINE(negozio, data_ordine, prodotto, quantita, fornitore)
values(N, curdate(), NEW.prodotto, NEW.soglia, F);

end if;
end;
|
delimiter ;
