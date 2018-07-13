CREATE VIEW reparti_amministrati(dipendente, num_reparti) AS
SELECT dipendente, count(DISTINCT reparto)
FROM RESPONSABILE
GROUP BY dipendente;