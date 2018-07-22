CREATE PROCEDURE check_assunzione(matricola int, data_inizio date, data_fine date)
begin

if((data_fine is not null) and datediff(data_inizio, data_fine) > 0) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'data_inizio > data_fine';
end if;

if(exists (
		select LAVORA.dipendente 
        from LAVORA 
        where LAVORA.dipendente = matricola 
			and (((data_inizio >= LAVORA.data_fine and LAVORA.data_fine is null) or (LAVORA.data_fine > data_inizio and data_fine is not null and LAVORA.data_inizio < data_fine)) 
            or LAVORA.data_inizio = data_inizio)
        )
	)then
    signal sqlstate '45000' set MESSAGE_TEXT = 'periodo di tempo compreso in un periodo di lavoro preesistente in LAVORA';
end if;

if(exists (
		select RESPONSABILE.dipendente 
		from RESPONSABILE 
        where RESPONSABILE.dipendente = matricola 
			and (((data_inizio >= RESPONSABILE.data_fine and RESPONSABILE.data_fine is null) or (RESPONSABILE.data_fine > data_inizio and data_fine is not null and RESPONSABILE.data_inizio < data_fine)) 
            or RESPONSABILE.data_inizio = data_inizio)
        )
	) then
    signal sqlstate '45000' set MESSAGE_TEXT = 'periodo di tempo compreso in un periodo di lavoro preesistente in RESPONSABILE';
end if;

if(exists (
		select MANAGER.dipendente 
		from MANAGER 
        where MANAGER.dipendente = matricola 
			and (((data_inizio >= MANAGER.data_fine and MANAGER.data_fine is null) or (MANAGER.data_fine > data_inizio and data_fine is not null and MANAGER.data_inizio < data_fine)) 
            or MANAGER.data_inizio = data_inizio)
		)
	) then
    signal sqlstate '45000' set MESSAGE_TEXT = 'periodo di tempo compreso in un periodo di lavoro preesistente in MANAGER';
end if;

end