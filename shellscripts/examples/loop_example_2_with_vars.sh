#!/bin/bash
DATABASE="crawler_data_2015_07"
SPIDERS="site1 site2"
for spider in $SPIDERS; do
    mongoexport -d $DATABASE -c items -q '{"_meta.spider_name": "'${spider}'"}' -f '_id.id,ean,brand,name,product_type,price,special_price,department,category,url,available,instalments,instalment_value,image_url,variation_label,tyre.width,tyre.aspect_ratio,tyre.rim_diameter,tyre.load_index,tyre.speed_rating' --csv > $spider.csv
done
