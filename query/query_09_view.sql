CREATE VIEW fid_totali(negozio, num_fid) AS
SELECT negozio, count(*)
FROM `FIDELITY CARD`
GROUP BY negozio;