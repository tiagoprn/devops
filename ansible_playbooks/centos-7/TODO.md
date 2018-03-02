Exemplo de queries de vmstat para adicionar no grafana: 

SELECT mean("value") AS cs FROM "vmstat_value" WHERE $timeFilter AND type_instance='cs' GROUP BY time($__interval) fill(null);
SELECT mean("value") AS wa FROM "vmstat_value" WHERE $timeFilter AND type_instance='wa' GROUP BY time($__interval) fill(null);
SELECT mean("value") AS in_m FROM "vmstat_value" WHERE $timeFilter AND type_instance='in' GROUP BY time($__interval) fill(null);

