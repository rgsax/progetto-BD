-- ------------------------------------------------------------------------------------------------------------------
-- 6. Visualizzare i negozi che utilizzano un solo locale all’interno del centro commerciale.
-- ------------------------------------------------------------------------------------------------------------------
SELECT negozio
FROM LOCALE
GROUP BY negozio
HAVING count(*) = 1;