# Development
    Ağağıdaki bilgileri kullanarak WebsiteTracker projesinin development ortamını oluşturabilirsiniz. Development ortamını oluştururken bilgisayardaki dosyaların bir volume gibi container içerisine gösterilir. Bu şekilde bilgisayardaki projenin içerisinde herhangi bir değişiklik yapıldığında container ın içindeki dosyalar da değişir. Oluşturulan imaj da bu şekilde çalışmaktadır.

### Build
    docker build -t bear/website_tracker:<version_number> -f Dockerfile-dev .
    
        - version_number (required): Version numarası

### First Run
    docker run -td --name <name_of_container> -e ELASTIC_URL=<elastic_url> -v <website_tracker_php_project_directory>:/var/www/html bear/website_tracker:<version_number>

        - elastic_url (required): 
        Elasticsearch ün stanalone veya cluster url adresidir. "http://" olmadan yazılmalıdır.

        - version_number (required): Build ederken imaj a verilen version numarası buraya yazılmalıdır.
        - name_of_container (required): Docker build ettikten sonra oluşan imajdan bir container oluştururken container a bir isim verilmelidir.
        
        - website_tracker_php_project_directory (required): Website Tracker projesinin tam klasör yolunu buraya yazmalısınız. Bunun amacı projede yapılan bir değişikliğin direk olarak uygulamasını görmektir. Diğer türlü projede yapılan bir değişikliğin container içerisine gönderilmesi gerekmektedir.

### Start
    docker start <name_of_container>

### Stop
    docker stop <name_of_container>

# Production
    Aşağıdaki bilgileri kullanarak WebsiteTracker projesini production ortamında kullanabilirsiniz.

### Build
    docker build -t bear/website_tracker:<version_number> .

        - version_number (required): Version numarası

### First Run
    docker run -td --name <name_of_container> -e ELASTIC_URL=<elastic_url> bear/website_tracker:<version_number>

        - elastic_url (required): Elasticsearch ün stanalone veya cluster url adresidir. "http://" olmadan yazılmalıdır.
    
        - version_number (required): Build ederken imaj a verilen version numarası buraya yazılmalıdır.

        - name_of_container (required): Docker build ettikten sonra oluşan imajdan bir container oluştururken container a bir isim verilmelidir.

### Start
    docker start <name_of_container>

### Stop
    docker stop <name_of_container>
