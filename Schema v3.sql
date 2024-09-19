
CREATE TABLE Populations (
                id_pop INT AUTO_INCREMENT NOT NULL,
                pop_mun INT,
                pop_cap INT,
                pop_tot INT,
                PRIMARY KEY (id_pop)
);


CREATE TABLE Regions (
                id_region INT AUTO_INCREMENT NOT NULL,
                code_depcom_reg VARCHAR(5) NOT NULL,
                groupe_region VARCHAR(50) NOT NULL,
                code_region INT NOT NULL,
                nom_region VARCHAR(50) NOT NULL,
                code_oldregion VARCHAR(2) NOT NULL,
                nom_odlregion VARCHAR(50) NOT NULL,
                nom_departement VARCHAR(50) NOT NULL,
                PRIMARY KEY (id_region)
);


CREATE TABLE Communes (
                id_commune INT AUTO_INCREMENT NOT NULL,
                id_region INT NOT NULL,
                id_pop INT NOT NULL,
                code_depcom VARCHAR(5) NOT NULL,
                code_dep VARCHAR(2) NOT NULL,
                code_com VARCHAR(3) NOT NULL,
                nom_com VARCHAR(50) NOT NULL,
                PRIMARY KEY (id_commune)
);


CREATE TABLE Biens (
                id_bien INT AUTO_INCREMENT NOT NULL,
                id_commune INT NOT NULL,
                no_voie VARCHAR(15) NOT NULL,
                voie VARCHAR(50) NOT NULL,
                code_postal INT NOT NULL,
                code_depcom INT NOT NULL,
                type_local VARCHAR(50) NOT NULL,
                nbre_pieces INT NOT NULL,
                surface_carrez DOUBLE PRECISIONS NOT NULL,
                surface_reelle INT NOT NULL,
                PRIMARY KEY (id_bien)
);


CREATE TABLE Vente (
                id_vente INT AUTO_INCREMENT NOT NULL,
                id_bien INT NOT NULL,
                date DATE NOT NULL,
                valeur DOUBLE PRECISIONS,
                PRIMARY KEY (id_vente)
);


ALTER TABLE Communes ADD CONSTRAINT populations_communes_fk
FOREIGN KEY (id_pop)
REFERENCES Populations (id_pop)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Communes ADD CONSTRAINT regions_communes_fk
FOREIGN KEY (id_region)
REFERENCES Regions (id_region)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Biens ADD CONSTRAINT communes_biens_fk
FOREIGN KEY (id_commune)
REFERENCES Communes (id_commune)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Vente ADD CONSTRAINT biens_vente_fk
FOREIGN KEY (id_bien)
REFERENCES Biens (id_bien)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
