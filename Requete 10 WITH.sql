WITH appartement_2 AS
	(SELECT
	round(AVG(valeur/b.surface_carrez)) as F2
	FROM vente AS v
		JOIN biens as b ON b.id_bien = v.id_bien
	WHERE
		b.nbre_pieces = 2),
	appartement_3 AS
	(SELECT
	round(AVG(valeur/b.surface_carrez)) as F3
	FROM vente AS v
		INNER JOIN biens as b ON b.id_bien = v.id_bien
	WHERE
		b.nbre_pieces = 3)
SELECT 
F2 as "Appartement 2 pièces (F2)",
F3 as "Appartement 3 pièces (F3)",
round(((F3 / F2)-1) * 100,2) as "Différence de prix en %" 
	FROM appartement_2, appartement_3;