delimiter |
create trigger insert_check_acquisti
before insert on ACQUISTI
for each row
begin

if(NEW.prodotto not in (select prodotto
						from (IN_VENDITA inner join REPARTO on IN_VENDITA.reparto = REPARTO.codice_reparto), SCONTRINO
                        where SCONTRINO.codice_scontrino = NEW.scontrino and SCONTRINO.negozio = REPARTO.negozio)) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'prodotto non in vendita nel reparto';
end if;

if(NEW.quantita > (select quantita_esposta 
					from (IN_VENDITA inner join REPARTO on IN_VENDITA.reparto = codice_reparto) inner join SCONTRINO on REPARTO.negozio = SCONTRINO.negozio
                    where codice_scontrino = NEW.scontrino and NEW.prodotto = IN_VENDITA.prodotto)) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'quantita\' richiesta non disponibile';
end if;
end;

create trigger insert_check_campagna_promozionale
before insert on CAMPAGNA_PROMOZIONALE
for each row
begin

if(datediff(NEW.data_inizio, NEW.data_fine) > 0) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'data_inizio > data_fine';
end if;
end;

create trigger rimuovi_campagna_promozionale
before delete on CAMPAGNA_PROMOZIONALE
for each row
begin

delete from PRODOTTI_SCONTATI
where campagna_promozionale = OLD.codice_campagna_promozionale;

end;

create trigger insert_check_collocamento
before insert on COLLOCAMENTO
for each row 
if(NEW.quantita < NEW.soglia) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'quantita\' inferiore alla soglia specificata';
end if;

create trigger rimuovi_categoria
before delete on CATEGORIA
for each row
begin

delete from PUO_FORNIRE
where categoria_prodotto = OLD.codice_categoria;

delete from FORNITURA
where categoria_prodotto = OLD.codice_categoria;

delete from SUBCATEGORIA
where categoria_prodotto = OLD.codice_categoria;

end;

create trigger rimuovi_cliente_fedele
before delete on `CLIENTE FEDELE`
for each row
begin

delete from `FIDELITY CARD`
where cliente = OLD.codice_fiscale;

end;

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

create trigger rimuovi_dipendente
before delete on DIPENDENTE
for each row
begin

delete from LAVORA
where dipendente = OLD.matricola;

delete from RESPONSABILE
where dipendente = OLD.matricola;

delete from MANAGER
where dipendente = OLD.matricola;

end;

create trigger insert_check_fidelity_card
before insert on `FIDELITY CARD`
for each row
begin

if(datediff(NEW.data_emissione, NEW.data_scadenza) > 0) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'data_emissione > data_scadenza';
end if;
end;

create trigger rimuovi_fornitore
before delete on FORNITORE
for each row
begin

delete from PUO_FORNIRE
where fornitore = OLD.P_IVA;

delete from FORNITURA
where fornitore = OLD.P_IVA;

delete from ORDINE
where fornitore = OLD.P_IVA;

end;

create trigger insert_check_in_vendita
before insert on IN_VENDITA
for each row
begin
declare C int;
declare NC int;

select categoria into C from REPARTO where codice_reparto = NEW.reparto;
select categoria_prodotto into NC from SUBCATEGORIA inner join PRODOTTO on subcategoria = codice_subcategoria where NEW.prodotto = codice_a_barre;
if(not(C = NC)) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'categoria non corrispondente a quella in vendita dal negozio';
end if;
end;

create trigger insert_check_lavora
before insert on LAVORA
for each row
begin

call check_assunzione(NEW.dipendente, NEW.data_inizio, NEW.data_fine);

end;

create trigger rimuovi_magazzino
before delete on MAGAZZINO
for each row
begin

delete from SCAFFALE
where SCAFFALE.codice_magazzino = OLD.codice_magazzino;

end;

create trigger insert_check_manager
before insert on MANAGER
for each row
begin

call check_assunzione(NEW.dipendente, NEW.data_inizio, NEW.data_fine);

end;

create trigger rimuovi_negozio
before delete on NEGOZIO
for each row
begin

delete from CAMPAGNA_PROMOZIONALE
where negozio = OLD.P_IVA;

delete from SCONTRINO
where negozio = OLD.P_IVA;

delete from `FIDELITY CARD`
where negozio = OLD.P_IVA;

delete from REPARTO
where negozio = OLD.P_IVA;

delete from MANAGER
where negozio = OLD.P_IVA;

delete from MAGAZZINO
where negozio = OLD.P_IVA;

delete from ORDINE
where negozio = OLD.P_IVA;

delete from FORNITURA
where negozio = OLD.P_IVA;

update LOCALE
set negozio = null
where negozio = OLD.P_IVA;

end;

create trigger rimuovi_prodotto
before delete on PRODOTTO
for each row
begin

delete from COLLOCAMENTO
where prodotto = OLD.codice_a_barre;

delete from IN_VENDITA
where prodotto = OLD.codice_a_barre;

delete from PRODOTTI_SCONTATI
where prodotto = OLD.codice_a_barre;

delete from ACQUISTI
where prodotto = OLD.codice_a_barre;

delete from ORDINE
where prodotto = OLD.codice_a_barre;

delete from TABELLA_VALORI_NUTRIZIONALI
where prodotto = OLD.codice_a_barre;

end;

create trigger rimuovi_reparto
before delete on REPARTO
for each row
begin

delete from LAVORA
where reparto = OLD.codice_reparto;

delete from RESPONSABILE
where reparto = OLD.codice_reparto;

delete from IN_VENDITA
where reparto = OLD.codice_reparto;

end;

create trigger insert_check_responsabile
before insert on RESPONSABILE
for each row
begin

call check_assunzione(NEW.dipendente, NEW.data_inizio, NEW.data_fine);

end;

create trigger rimuovi_ripiano
before delete on RIPIANO
for each row
begin

delete from COLLOCAMENTO
where ripiano = OLD.codice_ripiano;

end;

create trigger rimuovi_scaffale
before delete on SCAFFALE
for each row
begin

delete from RIPIANO
where scaffale = OLD.codice_scaffale;

end;

create trigger rimuovi_scontrino
before delete on SCONTRINO
for each row
begin

delete from ACQUISTI
where scontrino = OLD.codice_scontrino;

end;

create trigger rimuovi_subcategoria
before delete on SUBCATEGORIA
for each row
begin

delete from PRODOTTO
where subcategoria = OLD.codice_subcategoria;

end;

create trigger rimuovi_valore_nutrizionale
before delete on `VALORE NUTRIZIONALE`
for each row
begin

delete from TABELLA_VALORI_NUTRIZIONALI
where valore = OLD.codice_valore;

end;
|

delimiter ;