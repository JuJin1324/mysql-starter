# mysql-starter

## 설치
### macOS
> mysql 5.x  
> `brew install mysql@5.x`  
>
> mysql 8.x
> `brew install mysql`  
> 
> mysql service 시작  
> `brew services start mysql`  
> 
> version 확인  
> `mysql --version`

### ubuntu
> mysql 8.x  
> `sudo apt update; sudo apt install -y mysql-server`
>
> mysql service 시작  
> `service mysql start`  
> 
> version 확인  
> `mysql --version`

### docker
> mysql 5.x  
> `docker run -d -p 3306:3306 --name starter-mysql mysql:5.7`
> 
> mysql 8.x  
> `docker run -d -p 3306:3306 --name starter-mysql mysql:8.0`
>
> version 확인  
> `docker exec -it starter-mysql mysql --version`

---

