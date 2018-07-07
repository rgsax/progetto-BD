select codice_carta
from `FIDELITY CARD`
where datediff(curdate(), data_emissione) >= 2 * 365 and not exists ( select *
					from SCONTRINO
					where codice_carta = fidelity_card and datediff(curdate(), data_emissione) < 2 * 365);
                                