sudo docker pull siraom15/clinic-database-image

sudo docker run -d -p 443:3306 --rm --name database siraom15/clinic-database-image