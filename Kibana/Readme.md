# Development
    Ağağıdaki bilgileri kullanarak Kibana projesinin development ortamını oluşturabilirsiniz.

    Buradaki amaç Website Tracker prpjesinden elasticsearch e gönderilen verilerin Kibana tarafından yorumlanıp görselleştirilmesidir.

    Development ortamı kurulduktan sonra;
        # http://<container_ip_adress>:5601
    adresinden kibana arayüzüne ulaşılır.

    Burada elasticsearch verilerini kullanarak dashboardlar tasarlanır ve dashboardlar tasarlandırktan sonra "projects" klasöründe bulunan "SimpleKibanaBackupRestoreSavedObjects" projesi kullanılarak kibanada oluşturulan "index-pattern, visualization ve dashboard" lar export edilir. Buradan export edilen dahsboard direk olarak "kibana saved_objects/_bulk_create" api si üzerinden yüklenebilir haldedir. Buradan export edilen "json" dosyasını "data" klasörü altına "saved_object.json" olarak koyup tekrardan build edebilirsiniz.

### Build
    docker build -t bear/kibana:6.4.2 .

### First Run
<pre>
    <b>Volume oluştur (required): </b>
        Plugin lerin kaybolmaması için data volume oluşturulmalıdır.

        $> docker create volume <volume_name>
<pre>
    - volume_name (required): Oluşturulan volume alanına bir isim verilmesi gerekmektedir. Proje ve yaptığı işe ile alakalı bir isim vermek mantıklı olabilir.
</pre></pre>
<pre>
    <b>First Run:</b>
        $> docker run -td --name <name_of_container> -v <volume_name>:/data -e SERVER_NAME=<server_name> -e ELASTIC_URL=<elastic_url> bear/kibana:6.4.2
<pre>
    - volume_name (required): Bir önceki adımda oluşturulan volume ün ismi buraya yazılmalıdır.

    - server_name (required): Birçok kibana birbirine bağlanarak (cluster) çalışabildiği için kibanaları birbirinden ayırmak için bu değişkene ihtiyaç vardır.

    - elastic_url (required): Elasticsearch ün stanalone veya cluster url adresidir. url adresinde "http://" olmalıdır.

    - name_of_container (required): Docker build ettikten sonra oluşan imajdan bir container oluştururken container a bir isim verilmelidir.
</pre></pre>    
    - Önemli:
        Container ilk çalıştırıldığında 5-10 dk arasında sürebilmektedir. Hatalar ve çalışma bilgisi için docker loglarını kontrol edebilirsiniz. Docker loglarnı kontrol etmek için; 
        $> docker log <container_name> kullanılabilir.

### Start
    docker start <name_of_container>

### Stop
    docker stop <name_of_container>


# Production
    Aşağıdaki bilgileri kullanarak WebsiteTracker projesini production ortamında kullanabilirsiniz.
# Development
    Ağağıdaki bilgileri kullanarak Kibana projesinin development ortamını oluşturabilirsiniz.

### Build
    docker build -t bear/kibana:6.4.2 .

### First Run
<pre>
    <b>Volume oluştur (required): </b>
        Plugin lerin kaybolmaması için data volume oluşturulmalıdır.

        $> docker create volume <volume_name>
<pre>
    - volume_name (required): Oluşturulan volume alanına bir isim verilmesi gerekmektedir. Proje ve yaptığı işe ile alakalı bir isim vermek mantıklı olabilir.
</pre></pre>
<pre>
    <b>First Run:</b>
        $> docker run -td --name <name_of_container> -v <volume_name>:/data -e SERVER_NAME=<server_name> -e ELASTIC_URL=<elastic_url> bear/kibana:6.4.2
<pre>
    - volume_name (required): Bir önceki adımda oluşturulan volume ün ismi buraya yazılmalıdır.

    - server_name (required): Birçok kibana birbirine bağlanarak (cluster) çalışabildiği için kibanaları birbirinden ayırmak için bu değişkene ihtiyaç vardır.

    - elastic_url (required): Elasticsearch ün stanalone veya cluster url adresidir. url adresinde "http://" olmalıdır.

    - name_of_container (required): Docker build ettikten sonra oluşan imajdan bir container oluştururken container a bir isim verilmelidir.
</pre></pre>    
    - Önemli:
        Container ilk çalıştırıldığında 5-10 dk arasında sürebilmektedir. Hatalar ve çalışma bilgisi için docker loglarını kontrol edebilirsiniz. Docker loglarnı kontrol etmek için; 
        $> docker log <container_name> kullanılabilir.

### Start
    docker start <name_of_container>

### Stop
    docker stop <name_of_container>

# KURULU PLUGINLER
## 1) Datasweet Formula
#### Kurulum :
    $> kibana-plugin install https://github.com/datasweet/kibana-datasweet-formula/releases/download/v2.0.0/datasweet_formula-2.0.0_kibana-6.4.2.zip    


#### URL :
    https://github.com/datasweet/kibana-datasweet-formula


## 2) Kibana Enhanced Table
#### Kurulum
    $> kibana-plugin install https://github.com/fbaligand/kibana-enhanced-table/releases/download/v1.0.0/enhanced-table-1.0.0_6.4.2.zip

#### URL
    https://github.com/fbaligand/kibana-enhanced-table

## Kibana Time
#### Kurulum
    $> cd KIBANA_HOME/plugins
    $> git clone https://github.com/nreese/kibana-time-plugin.git
    $> cd KIBANA_HOME/plugins/kibana-time-plugin
    $> git checkout 6.4
    $> bower install
    $> vi kibana-time-plugin/package.json //set version to match kibana version

#### URL
    https://github.com/nreese/kibana-time-plugin