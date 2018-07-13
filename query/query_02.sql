-- ------------------------------------------------------------------------------------------------------------------
-- 2. Modificare il numero di telefono e l’indirizzo di un certo dipendente.
-- ------------------------------------------------------------------------------------------------------------------

UPDATE DIPENDENTE
SET telefono = "090337642",
	indirizzo_residenza = "via indirizzo residenza 20"
WHERE matricola = 12346;