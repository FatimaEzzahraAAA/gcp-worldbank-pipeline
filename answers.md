## Bonus 1 : Que se passe-t-il pour le reste du DAG si la tâche de contrôle qualité échoue ?

Si le BigQueryCheckOperator échoue, la tâche est marquée comme failed. 
Toutes les tâches dépendantes en aval seront automatiquement marquées comme upstream_failed et ne s'exécuteront pas.
Cela permet de bloquer la propagation de données de mauvaise qualité vers les étapes suivantes du pipeline.

## Bonus 2 : Quel avantage apportent le partitionnement et le clustering ?

Le partitionnement par load_date limite la quantité de données scannées lors des requêtes filtrées par période (ex: WHERE load_date = '2026-11-02'), ce qui réduit considérablement les coûts BigQuery. 
Le clustering par country_code trie physiquement les données au sein de chaque partition, accélérant les requêtes filtrées par pays (ex: WHERE country_code = 'MAR') en ne lisant que les blocs de données pertinents.
