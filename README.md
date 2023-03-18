# mysql-starter

## 설치
### version 선택 팁
> 기존 솔루션이 특정 버전만 지원하는 경우와 같은 제약 사항이 존재하지 않는다면 가능한 한 최신 버전을 설치하는 것이 좋다.  
> 기존 버전에서 새로운 메이저 버전(5.5, 5.6, 5.7, 8.0)으로 업그레이드하는 경우라면 최소 패치 버전이 15~20번 이상 릴리즈된 버전을 선택하는 것이
> 안정적인 서비스에 도움이 될 것이다. 즉 MySQL 8.0 버전 선택시 8.0.15 이상의 버전을 선택하는 것이 안정적인 서비스에 도움이 된다.  

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

### Ubuntu
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

## 서버 연결
### mycli
> mycli 는 mysql client 로 자동 완성 등의 추가 기능을 제공하는 클라이언트이다.  
> 
> 설치 - macOS  
> `brew install mycli`  
> 
> 설치 - Ubuntu  
> `sudo apt update; sudo apt install -y mycli`  

### 연결
> `mycli -u <username> -p --host=<host IP address> --port=<port>`  
> host 를 localhost 로 명시하는 것과 127.0.0.1 로 명시하는 것은 각각 의미가 다르다. --host=localhost 옵션을 사용하면 MySQL 클라이언트 프로그램은 항상
> 소켓 파일을 통해 MySQL 서버에 접속하게 되는데, 이는 'Unix domain socket' 을 이용하는 방식으로 TCP/IP 를 통한 통신이 아니라 유닉스 프로세스 간 통신(IPC)의 일종이다.  
> 하지만 127.0.0.1 을 사용하는 경우에는 자기 서버를 가리키는 루프백(loopback) IP 이기는 하지만 TCP/IP 통신 방식을 사용하는 것이다.  
> 그래서 docker 사용 시 host 를 localhost 로 사용하면 connection refused 가 발생하여 연결이 되지 않으며 127.0.0.1 을 사용하거나 내부 IP 주소를 명시하여야 한다.      

---

## MySQL 서버 업그레이드
### 방법
> MySQL 서버를 업그레이드 하는 방법은 2가지 방법이 있다.  
> 1.인플레이스 업그레이드(In-Place Upgrade): MySQL 서버의 데이터 파일을 그대로 두고 업그레이드  
> 2.논리적 업그레이드(Logical Upgrade): mysqldump 도구 등을 이용해 MySQL 서버의 데이터를 SQL 문장이나 텍스트 파일로 덤프한 후, 새로 업그레이드된 버전의 
> MySQL 서버에서 덤프된 데이터를 적재.

### 인플레이스 업그레이드 제약 사항
> 동일 메이저 버전에서 마이너 버전 업데이트는 대부분 데이터 파일의 변경 없이 진행되며, 여러 버전을 건너뛰어서 업데이트하는 것도 허용된다. 예를 들어 MySQL 8.0.16 에서
> 8.0.21 버전으로 업데이트 시 MySQL 서버 프로그램만 재설치하면 된다.  
> 
> 하지만 메이저 버전 간 업그레이드는 대부분 크고 작은 데이터 파일의 변경이 필요하기 때문에 반드시 직전 버전에서만 업그레이드가 허용된다. 예를 들어 MySQL 5.5 버전에서
> 5.6 버전으로는 업그레이드가 가능하지만 5.5 버전에서 5.7 버전이나 8.0 버전으로 업그레이드는 지원하지 않는다.  
> 그래서 만약 두 단계 이상을 한 번에 업그레이드해야 한다면 논리적 업그레이드를 하는 것이 더 나은 방법일 수 있다.  
> 인플레이스 업그레이드 시 한가지 더 주의할 점은 메이저 버전 업그레이드가 특정 마이너 버전에서만 가능한 경우도 있다는 것이다. 메이저 버전 업데이트 시에는 MySQL 서버의 메뉴얼을
> 정독한 후 진행할 것을 권장한다.
