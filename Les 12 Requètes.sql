-- Active: 1669821708560@@127.0.0.1@3306@oc_projet_3
/* Question 1 : Nombre total d’appartements vendus au 1er semestre 2020. */

SELECT
    COUNT(*) AS 'ventes appartements au 1er semestre 2020'
FROM vente AS v
JOIN biens AS b ON v.id_bien = b.id_bien
WHERE
DATE BETWEEN "2020-01-01" AND "2020-06-30"
AND b.type_local = "appartement";
   
/* Question 2 : Le nombre de ventes d’appartement par région pour le 1er semestre 2020. */
   
SELECT 
    COUNT(v.id_vente) AS "Nbre_ventes" , nom_region AS "Regions"
FROM vente AS v
JOIN biens AS b ON b.id_bien = v.id_bien
JOIN communes AS c ON b.id_commune = c.id_commune
JOIN regions AS r ON c.id_region = r.id_region
WHERE
DATE BETWEEN "2020-01-01" AND "2020-06-30"
AND b.type_local = "appartement"
GROUP BY r.nom_region
ORDER BY nbre_ventes DESC;
    
/* Question 3 : Proportion des ventes d’appartements par le nombre de pièces. */    
    
SELECT
    ROUND(COUNT(v.id_vente) / tmp_table.nb * 100,2) AS 'proportion des ventes',
        b.nbre_pieces AS 'nombre de pièces'
FROM vente AS v
JOIN biens AS b ON b.id_bien = v.id_bien, 
    (SELECT COUNT(*) AS nb
FROM
        vente AS v,
        biens AS b
WHERE
        v.id_bien = b.id_bien
AND b.type_local = 'appartement') AS tmp_table
WHERE
        b.type_local = 'appartement'
GROUP BY b.nbre_pieces
ORDER BY b.nbre_pieces;

/* Question 4 : Liste des 10 départements où le prix du mètre carré est le plus élevé. */

SELECT
    round(AVG(v.valeur / b.surface_carrez),2) as 'prixSurface',
        nom_departement as 'departement'
FROM vente as v
JOIN biens AS b ON b.id_bien = v.id_bien
JOIN communes AS c ON b.id_commune = c.id_commune
JOIN regions AS r ON c.id_region = r.id_region
GROUP BY r.nom_departement
ORDER BY prixSurface 
DESC LIMIT 10;

/* Question 5 : Prix moyen du mètre carré d’une maison en Île-de-France. */

SELECT
    ROUND(AVG(v.valeur / b.surface_carrez),2) as "prix moyen €/m² Maison",
        r.nom_region as "île-de-France"
FROM vente as v
JOIN biens AS b ON b.id_bien = v.id_bien
JOIN communes AS c ON b.id_commune = c.id_commune
JOIN regions AS r ON c.id_region = r.id_region
WHERE
       b.type_local = "maison"
AND r.nom_region = "Île-de-France";
    
/* Question 6 : Liste des 10 appartements les plus chers, avec la région et le nombre de m². */    
    
SELECT
        b.id_bien AS 'id_bien',
        r.nom_region AS 'région',
        v.valeur AS 'prix en €',
        b.surface_carrez AS 'superficie en m²'
FROM biens AS b
JOIN communes AS c ON b.id_commune = c.id_commune
JOIN regions AS r ON c.id_region = r.id_region
JOIN vente AS v ON b.id_bien = v.id_bien
WHERE
        b.type_local = 'appartement'
ORDER BY v.valeur DESC
LIMIT 10;

/* Question 7 : Taux d’évolution du nombre de ventes entre le premier et le second trimestre de 2020. */

SELECT
        t1 AS "trimestre 1",
        t2 AS "trimestre 2", 
    ROUND(( (t2 - t1) / t1) * 100,2) AS "taux d'évolution des ventes"
FROM (
SELECT 
    COUNT(*) AS t2
FROM vente
WHERE
DATE BETWEEN "2020-04-01" AND "2020-06-30") t2
JOIN (
SELECT 
    COUNT(*) as t1
FROM vente
WHERE
date BETWEEN "2020-01-01" AND "2020-03-31") t1;


    
/* Question 8 : Le classement des régions par rapport au prix au mètre carré des appartement de plus de 4 pièces. */    
    
SELECT
    ROUND(AVG(v.valeur / b.surface_carrez),2) AS 'prixSurface',
        r.nom_region AS 'région'
FROM vente AS v
JOIN biens AS b ON b.id_bien = v.id_bien
JOIN communes AS c ON b.id_commune = c.id_commune
JOIN regions AS r ON c.id_region = r.id_region
WHERE b.type_local = "Appartement" 
AND b.nbre_pieces > 4
GROUP BY r.nom_region
ORDER BY prixSurface DESC;

/* Question 9 : Liste des communes ayant eu au moins 50 ventes au 1er trimestre. */

SELECT
    COUNT(v.id_vente) AS ventes,c.nom_com
FROM communes AS c
JOIN biens AS b ON b.id_commune = c.id_commune
JOIN vente AS v ON b.id_bien = v.id_bien
WHERE
        v.date BETWEEN "2020-01-01" AND "2020-03-31"
GROUP BY c.nom_com
HAVING (count(v.id_vente) > 50)
ORDER BY
    COUNT(v.id_vente) DESC;
        
/* Question 10 : Différence en pourcentage du prix au mètre carré entre un appartement de 2 pièces et un appartement de 3 pièces. */

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
JOIN biens as b ON b.id_bien = v.id_bien
WHERE
		b.nbre_pieces = 3)
SELECT 
        F2 as "Appartement 2 pièces (F2)",
        F3 as "Appartement 3 pièces (F3)",
    round(((F3 / F2)-1) * 100,2) as "Différence de prix en %" 
FROM appartement_2, appartement_3;

/* Question 11v1 : Les moyennes de valeurs foncières pour le top 3 des communes des départements 6, 13, 33, 59 et 69 */    
    
SELECT *
FROM (
SELECT
    RANK() OVER 
            (PARTITION BY code_dep ORDER BY prix_moyen DESC) AS Rang,  
        nom_com, 
        prix_moyen,
        code_dep
FROM 
            (SELECT
        c.nom_com, 
        r.code_dep, 
    ROUND(AVG(v.valeur), 2) AS prix_moyen       
FROM communes AS c
JOIN biens AS b
ON b.id_commune = c.id_commune
JOIN vente AS v
ON v.id_bien = b.id_bien
JOIN regions AS r
ON c.id_region = r.id_region
WHERE r.code_dep IN ("06", "13", "33", "59", "69")
GROUP BY c.nom_com
ORDER BY c.id_commune) 
AS sub) 
AS sub2
WHERE Rang <=3 ;

/* Question 11v2 : Les moyennes de valeurs foncières pour le top 3 des communes des départements 6, 13, 33, 59 et 69 */

WITH valeur_par_ville AS
	(SELECT
		    c.nom_com, 
		AVG(v.valeur) AS "valeur", 
		    r.code_dep
	FROM vente AS v
	JOIN biens AS b ON v.id_bien = b.id_bien
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
	FROM valeur_par_ville) AS resultat
WHERE Rang <=3;

/* Question 12v1 : Les 20 communes avec le plus de transactions pour 1000 habitants pour les communes qui dépassent les 10 000 habitants. */

SELECT
    ROUND(COUNT(id_vente)/p.pop_tot*1000,2) AS "Nbre_vente_pour_1000_habitant",
        p.pop_tot AS "population",
        nom_com AS "ville"
FROM vente AS v
JOIN biens AS b ON v.id_bien = b.id_bien
JOIN communes AS c ON b.id_commune = c.id_commune
JOIN populations AS p ON c.id_pop = p.id_pop
WHERE p.pop_tot > 10000
GROUP BY c.nom_com
ORDER BY Nbre_vente_pour_1000_habitant DESC LIMIT 20;

/* Question 12v2 : Les 20 communes avec le plus de transactions pour 1000 habitants pour les communes qui dépassent les 10 000 habitants. */

SELECT b.code_postal, c.nom_com AS "nom commune",
    ROUND(AVG(b.surface_carrez),0) AS "Surface Carrez moyenne", 
	ROUND(AVG(v.valeur),0) AS "Valeur fonctière moyenne",  
	ROUND((COUNT(v.id_vente))/pop_tot*1000,2) AS "nombre_d_achat_pour_mille_habitants"
FROM vente AS v
JOIN biens AS b ON v.id_bien = b.id_bien
JOIN communes AS c ON b.id_commune = c.id_commune
JOIN Populations AS p ON c.id_pop = p.id_pop
JOIN regions AS r ON c.id_region = r.id_region
WHERE b.surface_carrez != 0 
AND r.code_dep IS NOT NULL 
AND p.pop_tot > 10000 
GROUP BY c.nom_com
ORDER BY nombre_d_achat_pour_mille_habitants 
DESC LIMIT 20;



/* Question 11 : TEST */

WITH valeur_par_ville AS
	(SELECT
		    c.nom_com, 
		AVG(v.valeur) AS "valeur", 
		    r.code_dep
	FROM vente AS v
	JOIN biens AS b ON v.id_bien = b.id_bien
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
	FROM valeur_par_ville) AS resultat
WHERE Rang <=3;
        

/* TEST */

with moyennes_valeur_fonciere_commune as
(select
c.nom_com,
avg(v.valeur) as 'valeurs',
r.code_dep
FROM vente AS v
	JOIN biens AS b ON v.id_bien = b.id_bien
        INNER JOIN communes AS c ON b.id_commune = c.id_commune
        INNER JOIN regions AS r ON c.id_region = r.id_region
WHERE r.code_dep IN("06", "13", "33", "59", "69")
GROUP BY r.code_dep, c.nom_com)

select code_dep as 'departement',
nom_com as 'commune',
round(valeurs,2) as 'valeur_fonciere_moyenne'
from 
(select code_dep, nom_com, valeurs, 
rank () over(partition by c.code_dep order by valeurs desc) as rang 
from moyennes_valeur_fonciere_commune) as resultat
where rang <= 3;

Select count(*)