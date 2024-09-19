WITH valeur_par_ville AS
	(SELECT
		c.nom_com, 
		AVG(v.valeur) AS "valeur", 
		r.code_dep
	FROM vente AS v
		INNER JOIN biens AS b ON v.id_bien = b.id_bien
        INNER JOIN communes AS c ON b.id_commune = c.id_commune
        INNER JOIN regions AS r ON c.id_region = r.id_region
	WHERE r.code_dep IN("06", "13", "33", "59", "69")
    GROUP BY r.code_dep, c.nom_com)

SELECT 
	code_dep AS "departement",
    nom_com AS "commune", 
    round(valeur,2) AS "prix moyen"
FROM
	(SELECT
		code_dep,
        nom_com,
        valeur,
        RANK() OVER (PARTITION BY code_dep ORDER BY valeur DESC) AS Rang
	FROM valeur_par_ville) AS recultat
WHERE Rang <=3
    
    