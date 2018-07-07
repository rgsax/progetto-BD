delimiter |
create event disabilita_schede 
on schedule every 1 day
do
begin
delete from `FIDELITY CARD`
where datediff(curdate(), data_emissione) >= 2 * 365 and not exists (
	select *
	from SCONTRINO
	having fidelity_card = codice_carta and datediff(curdate(), SCONTRINO.data_emissione) < 2 * 365);
end;
|
delimiter ;