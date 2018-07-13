-- ------------------------------------------------------------------------------------------------------------------
-- 7. Visualizzare il dipendente che è stato responsabile del maggior numero di reparti nel
-- 		centro commerciale.
-- ------------------------------------------------------------------------------------------------------------------
SELECT dipendente
FROM reparti_amministrati
WHERE num_reparti = (SELECT max(num_reparti) FROM reparti_amministrati);