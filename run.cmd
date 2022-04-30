docker build -t clinic-db-img .

docker run -d -p 443:3306 --name clinic-db-container clinic-db-img