# 🏠 OC - Projet 3 : Créez et utilisez une base de données immobilière avec SQL

Ce projet s’inscrit dans la stratégie de transformation numérique de **Laplace Immo**, un réseau national d’agences immobilières. L’objectif est de concevoir et d’exploiter une **base de données relationnelle** pour modéliser le marché immobilier français, dans le cadre du projet interne **DATAImmo**.

---

## 🎯 Objectif de la mission

> Créer une base de données normalisée et fonctionnelle pour faciliter l’analyse du marché immobilier, et aider les agences à estimer le prix de vente des biens.

---

## 🗂️ Étapes du projet

1. **Analyse des fichiers sources**
   - Données DVF (Demandes de Valeurs Foncières)
   - Données INSEE (recensement population)
   - Données géographiques (communes, régions, départements)

2. **Dictionnaire de données**
   - Élaboration complète dans un fichier Excel (`P3_dictionnaire_de_donnees.xlsx`)
   - Conformité au template fourni

3. **Modélisation**
   - Refonte du **schéma relationnel** (3NF)
   - Intégration des nouvelles données régionales et démographiques
   - Diagramme final validé dans `P3_schéma.pdf`

4. **Implémentation de la base**
   - Création des tables sous MySQL
   - Insertion des données

5. **Extraction et requêtes SQL**
   - Série de requêtes répondant aux besoins exprimés dans le **compte rendu de réunion**
   - Résultats et requêtes documentés dans `P3_requetes.pdf`

---

## 📁 Arborescence du projet

```
├── P3_dictionnaire_de_donnees.xlsx       → Dictionnaire des données (3 sources)
├── P3_schéma.pdf                         → Schéma relationnel final (normalisé en 3NF)
├── P3_BDD.pdf                            → Présentation du projet et conception
├── P3_requetes.pdf                       → Résultats des requêtes SQL + code
├── data/                                 → Données DVF, INSEE, et géographiques
├── README.md                             → Présentation du projet
└── script_SQL/                           → Scripts de création de la base et des tables
```

---

## 🛠️ Technologies utilisées

- **SQL** (via MySQL / PostgreSQL)
- **Excel** pour le dictionnaire
- **Draw.io / dbdiagram.io** pour la modélisation
- **PDF** pour la restitution des livrables

---

## ✅ Résultats obtenus

- Modèle relationnel robuste, conforme à la 3NF
- Base de données interrogeable pour des besoins métiers précis
- Extraction facilitée des informations sur les ventes, la population et les régions

---

## 🧠 Auteur

Projet réalisé par **AnthonyJVID** dans le cadre du parcours *Data Analyst* chez OpenClassrooms.

---

## 📄 Licence

Projet éducatif pour illustrer les bonnes pratiques en modélisation relationnelle et manipulation de données publiques en SQL.
