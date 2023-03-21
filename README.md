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

## 사용자 및 권한
### 사용자 식별
> MySQL 은 사용자의 접속 지점(호스트 명이나 도메인 또는 IP 주소)도 계정의 일부가 된다.  
> 'jujin'@'localhost' 와 'jujin'@`\192.168.0.12' 는 다른 계정이다.  
> 모든 외부 컴퓨터에서 접속이 가능한 계정을 생성하기 위해서는 접속 지점에 % 를 명시하여 다음과 같은 형태로 계정을 생성한다: 'jujin'@'%'  
> 만약 계정이 다음 2개가 존재하고  
> 'jujin'@'localhost', 'jujin'@'%'  
> localhost 에서 jujin 계정을 로그인을 시도하면 접속 지점의 범위가 작은 것을 항상 먼저 선택함으로 'jujin'@'localhost' 가 선택되며  
> 두 계정의 패스워드가 다른 경우에 localhost 에서 'jujin'@'%' 의 패스워드를 통해서 접속하려하면 '비밀번호가 일치하지 않는다'라는 오류를 내며
> 접속을 거부한다.

### 사용자 계정 관리
> MySQL 8.0 부터 계정은 `시스템 계정(System account)` 과 `일반 계정(Regular account)` 로 구분된다.  
> 
> **시스템 계정**  
> 시스템 계정은 SYSTEM_USER 권한을 가진 계정이며 데이터베이스 서버 관리자를 위한 계정이다.  
> 시스템 계정은 일반 계정을 관리(생성, 삭제, 변경)할 수 있지만 일반 계정은 시스템 계정을 관리할 수 없다.    
> 계정 관리(계정 생성 및 삭제, 그리고 계정의 권한 부여 및 제거)가 가능하다.  
> 다른 세션(Connection) 및 현재 세션에서 실행 중인 쿼리를 강제 종료가 가능하다.  
>
> **Account lock**
> 계정 생성 시 또는 ALTER USER 명령을 사용해 계정을 사용하지 못하게 잠글지 여부를 결정한다.  
> `ACCOUNT LOCK`: 계정을 사용하지 못하게 잠금  
> `ACCOUNT UNLOCK`: 잠긴 계정을 다시 사용 가능 상태로 잠금 해제  
> 
> **Dual Password**  
> 애플리케이션 서버에서 공용으로 DB 서버를 사용하기 때문에 애플리케이션에서 사용하는 계정 정보는 패스워드 변경이 힘들었다. 
> 해당 계정의 패스워드를 변경하기 위해서는 계정을 사용하는 애플리케이션들을 모두 중단해야하기 때문이다.  
> 그래서 MySQL 8.0 부터 나온 기능이 Dual Password 기능으로 하나의 계정에 대해 2개의 패스워드를 가지게 할 수 있다.  
> 2개의 비밀번호는 primary 와 secondary 로 구분된다. 최근에 설정한 비밀번호가 primary 이며 old 비밀번호가 secondary 이다.  
> dual password 를 사용하려면 패스워드 변경 구문의 마지막에 `RETAIN CURRENT PASSWORD` 옵션을 추가하면 된다.  
> ```sql
> ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password' RETAIN CURRENT PASSWORD;
> ```
> primary 패스워드와 secondary 패스워드 중 아무거나 패스워드를 입력하면 계정에 로그인이 되기 때문에 이전의 패스워드를 사용하는 애플리케이션들에
> 영향이 가지 않는다. 하지만 결국 패스워드 변경 주기에 맞춰서 패스워드를 변경해야하는 상황이 또 온다.  
> 계정 당 패스워드는 최대 2개씩만 가질 수 있음으로 `RETAIN CURRENT PASSWORD` 옵션을 통해서 패스워드를 변경하게 되면 primary 뿐만 아니라
> secondary 패스워드도 같이 바뀌게 된다.  
> 그럼으로 secondary 패스워드는 임시 패스워드라고 생각하고 변경 후 최대한 빨리 애플리케이션들의 커넥션 정보를 primary 패스워드로 변경 후 배포하고
> secondary 패스워드는 보안을 위해서도 제거하는 것이 좋다. 다음은 secondary 패스워드를 제거하는 명령이다.  
> ```sql
> ALTER USER 'root'@'localhost' DISCARD OLD PASSWORD;
> ```
> 
> **계정 쿼리 예시**  
> 1.내부 접근만 허용하는 계정 생성: `CREATE USER '<username>'@'localhost' identified by '<password>';`  
> 1-1.외부 접근을 허용하는 계정 생성: `CREATE USER '<username>'@'%' identified by '<password>';`  
>
> 2.계정 조회: `select user, host from mysql.user;`   
> 
> 3.계정 패스워드 변경(dual password 사용): `ALTER USER '<username>'@'<host>' IDENTIFIED BY '<new password>' RETAIN CURRENT PASSWORD;`  
> 
> 4.계정 삭제: `DROP USER '<username>'@'<host>';`

### 권한(Privilege)
> 권한은 글로벌 권한과 객체 권한으로 구분된다.  
> 
> **글로벌 권한**  
> 글로벌 권한은 계정 및 시스템에 관한 권한이며, 객체 권한은 주로 데이터베이스 및 테이블에 관한 권한이다.  
> 글로벌 권한은 특정 DB 나 테이블에 부여될 수 없기 때문에 글로벌 권한을 부여할 때 GRANT 명령의 ON 절에는 항상 `*.*` 를 사용한다.  
> 
> **권한 부여 명령어**  
> `GRANT <권한> ON <DB 명>.<Table 명> TO '<username>'@'<host>';`  
>
> **DB 권한**  
> DB 권한은 특정 DB 에 대해서만 권한을 부여하거나 서버에 존재하는 모든 DB 에 대해 권한을 부여할 수 있기 때문에 ON 절에 `*.*` 이나 
> `<DB 명>.*` 을 사용한다.  
> 
> **테이블 권한**  
> ```sql
> GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'user'@'localhost';
> GRANT SELECT, INSERT, UPDATE, DELETE ON employees.* TO 'user'@'localhost';
> GRANT SELECT, INSERT, UPDATE, DELETE ON employees.department TO 'user'@'localhost';
> ```
> 테이블 권한은 첫 번째 예제와 같이 서버의 모든 DB 에 대해 권한을 부여하는 것도 가능하며, 두 번째 예제와 같이 특정 DB 의 오브젝트에 대해서만 권한을 부여하는 것도 가능하다.  
> 그리고 세 번째 예제와 같이 특정 DB 의 특정 테이블에 대해서만 권한을 부여하는 것도 가능하다.  
>
> **칼럼 단위 권한**  
> 칼럼 단위의 권한은 잘 사용하지 않으며 칼럼 단위 권한이 하나라도 설정되면 나머지 모든 테이블의 모든 칼럼에 대해서도 권한 체크를 하기 때문에 
> 칼럼 하나에 대해서만 권한을 설정하더라도 전체적인 성능에 영향을 미칠 수 있다.  
> 
> **권한 쿼리 예시**  
> 1.특정 DB 에 대한 CRUD 권한 부여: `GRANT SELECT, INSERT, UPDATE, DELETE ON <DB 명>.* TO '<username>'@'<host>';`  
> 1-1.시스템 권한을 포함한 모든 권한 부여: `GRANT ALL PRIVILEGES ON *.* TO '<username>'@'<host>';`  
> 
> 2.권한 변경 후 적용: `FLUSH PRIVILEGES`  
> 
> 3.계정별 권한 조회: `SHOW GRANTS FOR '<username>'@'<host>';`      
> 참고. 계정 조회: `select user, host from mysql.user;`  
>
> 4.모든 권한 삭제: `REVOKE ALL ON <DB 명>.<테이블 명> FROM <username>`  
> 4-1.업데이트 권한 삭제: `REVOKE UPDATE ON <DB 명>.<테이블 명> FROM <username>`  

### 역할(Role)
> TODO
