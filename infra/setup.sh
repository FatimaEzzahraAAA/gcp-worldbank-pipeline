#!/bin/bash
# Script de configuration des ressources GCP

PROJECT_ID="data-maroc-bootcamp-airflow"
REGION="europe-west9"
BUCKET_NAME="${PROJECT_ID}-worldbank-raw"

# 1. Activer les APIs
gcloud services enable composer.googleapis.com \
    storage.googleapis.com bigquery.googleapis.com \
    iamcredentials.googleapis.com \
    --project=$PROJECT_ID

# 2. Créer le bucket
gcloud storage buckets create gs://$BUCKET_NAME --location=$REGION --project=$PROJECT_ID

# 3. Créer le dataset BigQuery
bq mk --dataset --location=$REGION $PROJECT_ID:raw_worldbank

# 4. Attribuer les rôles IAM au compte de service Composer
COMPOSER_SA="composer-env-sa@${PROJECT_ID}.iam.gserviceaccount.com"
gcloud storage buckets add-iam-policy-binding gs://$BUCKET_NAME --member="serviceAccount:$COMPOSER_SA" --role="roles/storage.objectAdmin"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$COMPOSER_SA" --role="roles/bigquery.dataEditor"
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:$COMPOSER_SA" --role="roles/bigquery.jobUser"
