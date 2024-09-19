    SELECT *
    FROM (
        SELECT
        RANK() OVER (PARTITION BY code_dep ORDER BY moyenne_commune DESC) AS Rang, 
        id_commune, 
        nom_com, 
        moyenne_commune,
        code_dep
        FROM (
            SELECT c.id_commune,
            c.nom_com, 
            r.code_dep, 
            ROUND(AVG(v.valeur), 2) AS moyenne_commune
            
            FROM communes AS c
                INNER JOIN biens AS b
                ON b.id_commune = c.id_commune
                INNER JOIN vente AS v
                ON v.id_bien = b.id_bien
                INNER JOIN regions AS r
                ON c.id_region = r.id_region

            WHERE r.code_dep IN ("06", "13", "33", "59", "69")
            GROUP BY c.nom_com
            ORDER BY c.id_commune) 
        AS sub) 
    AS sub2