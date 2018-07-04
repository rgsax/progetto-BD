delimiter |

create event disabilita_schede 
on schedule every 1 day
do
begin
delete from `FIDELITY CARD`
where codice_carta in (		select fidelity_card
							from SCONTRINO
							group by fidelity_card
							having min(datediff(curdate(), data_emissione)) >= 2 * 365)
								or codice_carta not in (select fidelity_card from SCONTRINO
					);
end;
|
delimiter ;