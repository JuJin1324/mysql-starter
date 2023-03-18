docker build --tag starter/mysql8:1.0 .; \
docker run -d \
-p 3311:3306 \
--name starter-mysql8 \
starter/mysql8:1.0
