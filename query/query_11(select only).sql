select codice_carta
from `FIDELITY CARD`
where codice_carta in (		select fidelity_card
							from SCONTRINO
							group by fidelity_card
							having min(datediff(curdate(), data_emissione)) >= 2 * 365)
								or codice_carta not in (select fidelity_card from SCONTRINO);