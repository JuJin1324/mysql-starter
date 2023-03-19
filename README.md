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

---

## 시스템 설정
### 설정 파일
> MySQL 은 설정파일로 my.cnf 파일을 사용한다.
> 하나의 my.cnf 파일 안에 여러 개의 설정 그룹을 담을 수 있으며 대체로 실행 프로그램 이름을 그룹명으로 사용한다.
> 예를 들어 mysqldump 프로그램은 [mysqldump] 설정 그룹을, mysqld 프로그램은 설정 그룹의 이름이 [mysqld] 인 영역을 참조한다.
> 각 프로그램 마다 다른 cnf 파일을 사용할 수 있으며 my.cnf 파일을 mysqld 프로그램에서만 사용한다면 [mysqld] 그룹만 설정파일에 기술하면 된다.  
> mysqldump, mysql 및 mysqld 등의 프로그램에서 모두 하나의 my.cnf 파일을 사용한다면 각 프로그램의 그룹에 설정 값들을 기술하면 된다.
> [mysqld] 와 [mysql] 에 각각 port 설정 값이 존재할 수 있으며 설정 파일 하나에 port 설정이 2개 이상이지만 각 그룹에만 적용이 된다.  

### 시스템 변수
> MySQL 서버는 설정 파일의 내용을 읽어 메모리나 작동 방식을 초기화하고, 접속된 사용자를 제어하기 위해 이러한 값을 별도로 저장해 둔다. 이 값들을 시스템 변수라고 한다.  
> 시스템 변수는 MySQL 서버에 접속해 `SHOW VARIABLES`(세션 변수) 또는 `SHOW GLOBAL VARIABLES`(글로벌 변수) 명령을 통해서 확인할 수 있다.  
> 
> 글로벌 변수  
> 하나의 MySQL 서버 인스턴스에서 전체적으로 영향을 미치는 시스템 변수를 의미하며, 주로 MySQL 서버 자체에 관련된 설정일 때가 많다.  
> innodb_buffer_pool_size 가 대표적인 예이다.  
> 
> 세션 변수  
> 클라이언트가 서버에 접속할 때 기본적으로 부여하는 옵션의 기본값을 제어하는데 사용된다. 여기서 기본값은 글로벌 변수이며 클라이언트의 필요에 따라
> 개별 커넥션 단위로 다른 값으로 변경할 수 있는 것이 세션 변수이다. autocommit 이 대표적인 예이다.  

### SET PERSIST
> 동적 변수는 MySQL 서버가 동작 중인 상태에서도 변경이 가능한 시스템 변수이다.  
> 동적 변수 변경 시 `SET GLOBAL <동적 변수명>=<값>` 명령을 사용하는데 이는 서버가 구동 중인 상태에서만 적용되며 서버가 중지된 후 재구동되면
> my.cnf 에 설정된 값으로 다시 변경된다.
> 
> 하지만 `SET PERSIST <동적 변수명>=<값>` 명령을 사용하면 해당 값을 mysqld-auto.cnf 파일에 저장하여 서버가 재구동될 시에도 서버에서 구동 시
> my.cnf 및 mysqld-auto.cnf 파일을 같이 읽어 서버에 반영하기 때문에 동적 변수 값을 영구 저장할 수 있다.  
> SET PERSIST 명령은 세션 변수에는 적용되지 않는다.  
> SET PERSIST 명령은 현재 구동 중인 시스템 변수의 변경 및 mysqld-auto.cnf 파일에도 변경된 시스템 변수를 저장한다.    
> SET PERSIST_ONLY 명령은 현재 구동 중인 시스템 변수는 변경하지 않고 mysqld-auto.cnf 파일에만 시스템 변수를 변경하여 저장한다.  
> 참고로 mysqld-auto.cnf 파일의 내부 구조는 JSON 포멧으로 되어있다.  

### 확인
> 시스템 변수 필터링해서 확인  
> ```sql
> show variables where variable_name in
>   ('max_connections', 'innodb_sort_buffer_size', 'innodb_log_files_in_group', 'innodb_log_file_size',
>   'innodb_buffer_pool_size', 'innodb_buffer_pool_instances', 'innodb_io_capacity',
>   'innodb_io_capacity_max', 'autocommit', 'default_storage_engine', 'lower_case_table_names',
>   'transaction_isolation', 'collation_server', 'character_set_server', 'character_set_filesystem',
>   'system_time_zone');
> ```

---

