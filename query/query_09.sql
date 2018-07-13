-- --------------------------------------------------------------------------------------------------------------------------------------
-- 9. Visualizzare i negozi che hanno un numero di clienti fedeli inferiore alla media degli
-- 		altri negozi.
-- --------------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM NEGOZIO INNER JOIN fid_totali ON P_IVA = negozio
WHERE num_fid < (SELECT avg(num_fid) FROM fid_totali);