    SELECT
    round(F2) as "2pièces",
    round(F3) as "3 pieces", round(((F3 / F2)-1) * 100,2) as "différence de prix en %"
FROM (SELECT
	AVG(valeur)/tmp_surf2.nb2 as F2
	FROM vente AS v
		INNER JOIN biens as b ON b.id_bien = v.id_bien,
			(SELECT
				AVG(surface_carrez) as nb2
			FROM biens as b)as tmp_surf2
	WHERE
		b.nbre_pieces = 2) F2
JOIN (SELECT
	AVG(valeur)/tmp_surf3.nb3 as F3
	FROM vente AS v
		INNER JOIN biens as b ON b.id_bien = v.id_bien,
			(SELECT
				AVG(surface_carrez) as nb3
			FROM biens as b)as tmp_surf3
	WHERE 
    b.nbre_pieces = 3) F3;