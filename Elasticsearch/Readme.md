# Developer / Production
    Ağağıdaki bilgileri kullanarak Kibana projesinin hen production hem development ortamını oluşturabilirsiniz.

## First Run
    docker run -td --name elasticsearch -e "discovery.type=single-node" elasticsearch:6.6.1

## Website Tracker Şemasını YÜkle
#### URL
    curl -XPUT -H "Content-Type: application/json" http://<elasticsearch_ip>:9200/action -d @<mapping_json_file>

    - mapping_json_file (Required): "projects" klasöründe "website_tracker" projesinin içerisindedir.