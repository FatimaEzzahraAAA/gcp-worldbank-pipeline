# World Bank Data Pipeline (GCP & Airflow)

Ce projet est un pipeline d'ingestion de données de bout en bout sur Google Cloud Platform (GCP).
Il interroge l'API publique de la Banque Mondiale, dépose les données brutes sur Cloud Storage, puis les charge dans BigQuery pour analyse.

## Architecture
1. **Cloud Composer (Airflow)** orchestre le processus.
2. **PythonOperator** extrait les données (PIB, Inflation, Population, Chômage, Espérance de vie) pour 5 pays (MAR, TUN, DZA, EGY, FRA).
3. Les données sont stockées temporairement en local, puis uploadées sur **Cloud Storage** (format CSV).
4. **GCSToBigQueryOperator** charge les données dans **BigQuery**.
5. La table est **partitionnée** par `load_date` et **clusterisée** par `country_code` pour optimiser les coûts et les performances.

## Structure du projet
- `dags/worldbank_dag.py` : Le code du DAG Airflow.
- `infra/setup.sh` : Les commandes gcloud pour préparer l'environnement (APIs, IAM, Buckets, Datasets).

## Comment exécuter
1. Créer l'environnement Cloud Composer.
2. Exécuter `infra/setup.sh` pour créer les ressources.
3. Uploader le fichier `worldbank_dag.py` dans le bucket `/dags` de Composer.
4. Activer et déclencher le DAG depuis l'interface Airflow

