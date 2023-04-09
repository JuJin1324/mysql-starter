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
> mysql 8.0
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
> mysql 5.7  
> `docker run -d -p 3306:3306 --name starter-mysql mysql:5.7`
> 
> mysql 8.0  
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
>   ('max_connections', 'innodb_sort_buffer_size', 'innodb_redo_log_capacity', 'innodb_log_buffer_size',
>   'innodb_buffer_pool_size', 'innodb_buffer_pool_instances', 'innodb_page_cleaners', 'innodb_io_capacity',
>   'innodb_io_capacity_max', 'autocommit', 'default_storage_engine', 'lower_case_table_names',
>   'innodb_table_locks', 'innodb_deadlock_detect', 'innodb_lock_wait_timeout',
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
> 'jujin'@'localhost', 'jujin'@'%'  ㅂ
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
> MySQL 8.0 부터 권한들을 묶은 역할을 생성할 수 있다.  
> 
> **역할 생성**  
> ```sql
> CREATE ROLE <role 이름>, <role 이름>, ...;
> ```
> 역할 생성 시 뒤에 %'<hostname>' 붙여서 역할을 생성할 수도 있는데 사실 역할의 정체는 로그인 정보가 없는 계정이기 때문이다.  
> 역할에 로그인 정보를 주어서 로그인이 가능해지는 경우 hostname 이 의미를 가지며 단순히 역할로 사용할 때는 hostname 의 의미가 없다.  
> 그래서 역할 생성 시 hostname 을 주지 않으며, hostname 을 주지 않으면 hostname 이 '%' 로 자동으로 붙여진다.   
>
> **역할에 권한 부여**  
> ```sql
> GRANT <권한> ON <DB 명>.<Table 명> TO <역할 명>;
> 
> # 예시
> GRANT SELECT ON employees.* TO role_emp_read;
> GRANT INSERT, UPDATE, DELETE ON employees.* TO role_emp_write;
> ```
> 
> **회원에 역할 부여**  
> ```sql
> GRANT <역할 명> TO '<username>'@'<hostname>';
> 
> # 예시 1: reader 와 writer 역할 권한을 부여
> GRANT role_application_writer, role_application_reader TO 'app_writer'@'%';
> 
> # 예시 2: reader 역할 권한만 부여
> GRANT role_application_reader TO 'app_reader'@'%';
> ```
> 
> **역할 목록 확인**  
> 역할은 회원과 동일하게 취급되기 때문에 mysql.user 테이블에 존재한다.  
> 다만 회원과 다른 점은 역할은 대부분 host 가 '%' 로 되어있으며(회원처럼 % 가 아닌 다른 host 를 설정할 수 있긴 하다.) 역할을 통해서는 로그인할 수 없기 때문에
> authentication_string 에는 빈 값이 들어가있다.(null 은 아니다.)
> ```sql
> SELECT user AS role_name
> FROM mysql.user
> WHERE host = '%'
> AND LENGTH(authentication_string);
> 
> # 혹은 역할 계정임을 나타내는 'role_' prefix 를 사용자가 임의로 넣어서 역할 계정을 관리하는 경우
> SELECT user AS role_name
> FROM mysql.user
> WHERE user like 'role_%' 
> ```
> MySQL 에서는 역할과 계정을 구분하지 않는다. 그래서 역할을 계정으로 변경시켜서 계정으로 사용할 수도 있다.  
> 역할과 계정을 구분하기 위해서는 사용자가 역할의 이름 앞에 'role_' 과 같이 prefix 혹은 뒤에 '_role' 과 같이 postfix 를 사용하여 해당 계정이
> 역할 계정임을 나타내는 것을 권장한다.
> 
> **역할 활성화**  
> 역할은 부여(GRANT) 만 한다고 역할의 권한 기능을 바로 사용할 수 없다.  
> 역할에 부여된 권한을 사용자가 사용하기 위해서는 연결된 세션(connection) 에서 `SET ROLE '<역할 명>'` 을 통해서 역할을 활성화 해주어야한다.  
> 연결된 세션 마다 해주어야하기 때문에 불편하고 수동적이다.  
> 이를 연결 시 자동으로 역할을 활성화해주는 옵션을 셋팅하면 해결 가능하다.  
> ```sql 
> SET GLOBAL activate_all_roles_on_login = ON;
> ```   
> 
> **회원에 부여된 역할 제거**  
> ```sql
> REVOKE <역할 명> from '<username>'@'<hostname>';
> 
> # 예시
> REVOKE role_app_writer from 'app_writer'@'%'; 
> ```

---

## 엔진
### 엔진과 스토리지 엔진
> MySQL 엔진 + 스토리지 엔진을 합쳐서 MySQL 서버라고 부른다.  
> MySQL 엔진의 종류는 1개이지만 스토리지 엔진의 종류는 여러가지이며 대표적으로 InnoDB 스토리지 엔진과 MyISAM 스토리지 엔진이 있다.  
> 스토리지 엔진은 테이블 생성 시에 지정을 할 수 있으며 각 테이블마다 다른 스토리지 엔진을 사용할 수 있다.  
> 스토리지 엔진은 데이터를 읽고 쓰는 기능만 처리하며 그 외의 작업은 모두 MySQL 엔진에서 처리된다.  
> MySQL 엔진이 각 스토리지 엔진에게 데이터를 읽어오가나 저장하도록 명령하려면 반드시 핸들러를 통해야 한다.  

### 백그라운드 스레드
> 백그라운드 스레드 중 가장 중요한 것은 로그 스레드와 버퍼의 데이터를 디스크로 내려쓰는 작ㅇ덥을 처리하는 쓰기 스레드(write thread)이다.  
> InnoDB 의 경우 MySQL 5.5 버전부터 데이터 쓰기 스레드와 데이터 읽기 스레드의 개수를 2개 이상 지정할 수 있다.  
> `innodb_write_io_threads` 와 `innodb_read_io_threads` 시스템 변수로 스레드의 개수를 설정한다.  
> 읽기 작업의 경우 주로 클라이언트 스레드(connection 마다 존재)에서 처리되기 때문에 많은 스레드 갯수가 필요하지 않지만 
> 쓰기 작업의 경우 내장 디스크를 사용할 때는 2~4 정도를 설정하는 것이 좋다.   
> 
> 읽기 및 쓰기 스레드 갯수 확인 쿼리  
> ```sql
> show global variables where variable_name like 'innodb_%_io_threads';
> ```

### 실행 엔진과 핸들러
> **실행 엔진**  
> 실행 엔진은 만들어진 계획대로 각 핸들러에게 요청해서 받은 결과를 또 다른 핸틀러 요청의 입력으로 연결하는 역할을 수행한다.  
> 
> **핸들러(스토리지 엔진)**  
> MySQL 실행 엔진의 요청에 따라 데이터를 디스크로 저장하고 디스크로부터 읽어오는 역할을 담당한다.  

### 쿼리 캐시
> MySQL 8.0 버전으로 오면서 쿼리 캐시의 기능이 사라졌다.  

### InnoDB 스토리지 엔진 아키텍처
> InnoDB 는 MySQL 에서 사용할 수 있는 스토리지 엔징 중 거의 유일하게 레코드 기반의 잠금을 제공하며, 그 때문에 높은 동시성 처리가 가능하고 안정적이며 성능이 뛰어나다.    
> InnoDB 의 모든 테이블은 기본적으로 프라이머리 키를 기준으로 클러스터링되어 저장된다. 즉, 프라이머리 키 값의 순서대로 디스크에 저장된다는 뜻이며, 모든 세컨더리 인덱스는 
> 레코드의 주소 대신 프라이머리 키의 값을 논리적인 주소로 사용한다.

### MVCC
> MVCC 의 가장 큰 목적은 잠금을 사용하지 않는 일관된 읽기를 제공하는 데 있다. InnoDB 는 언두 로그(Undo log)를 이용해 이 기능을 구현한다.
> 여기서 멀티 버전이라 함은 하나의 레코드에 대해 여러 개의 버전이 동시에 관리된다는 의미이다.    
> 하나의 트랜잭션에서 Update 쿼리가 실행되면 InnoDB 버퍼 풀에 있는 레코드가 갱신되며 레코드의 업데이트 이전의 내용은 언두 로그에 기록된다.  
> 다른 트랜잭션에서 동일 레코드를 조회 시에 READ_UNCOMMITTED 이면 InnoDB 버퍼 풀에 있는 레코드를 읽게 되며 그 외에 
> READ_COMMITTED, REPEATABLE_READ, SERIALIZABLE 의 경우에는 언두 로그에 기록된 레코드를 읽게 된다.  

### 자동 데드락 감지
> InnoDB 스토리지 엔진은 내부적으로 잠금이 교착 상태에 빠지지 않았는지 체크하기 위해 잠금 대기 목록을 그래프 형태로 관리한다.  
> InnoDB 스토리지 엔진은 데드락 감지 스레드를 가지고 있어서 데드락 감지 스레드가 주기적으로 잠금 대기 그래프를 검사해 교착 상태에 빠진 트랜잭션들을 찾아서
> 그중 하나를 강제 종료한다. 
> 
> InnoDB 스토리지 엔진은 상위 레이어인 MySQL 엔진에서 관리되는 테이블 잠금은 볼 수가 없어서 데드락 감지가 불확실할 수 도 있는데, `innodb_table_locks`
> 시스템 변수를 활성화하면 InnoDB 스토리지 엔진 내부의 레코드 잠금뿐만 아니라 테이블 레벨의 잠금까지 감지할 수 있게 된다. 특별한 이유가 없다면 `innodb_table_locks`
> 시스템 변수를 활성화하자.
> 
> 일반적인 서비스에서는 데드락 감지 스레드가 트랜잭션의 잠금 목록을 검사해서 데드락을 찾아내는 작업은 크게 부담되지 않는다.
> 하지만 동시 처리 스레드가 매우 많아지거나 각 트랜잭션이 가진 잠금의 개수가 많아지면 데드락 감지 스레드가 느려진다. 
> 이런 문제점을 해결하기 위해 MySQL 서버는 `innodb_deadlock_detect` 시스템 변수를 제공하며, OFF 설정 시 데드락 감지 스레드는 더이상 작동되지 않게 된다.
> 데드락 감지 스레드가 작동하지 않으면 InnoDB 스토리지 엔진 내부에서 2개 이상의 트랜잭션이 상대방이 가진 잠금을 요구하는 상황이 발생해도 누군가가 중재를
> 하지 않기 때문에 무한정 대기하게 될 것이다. 
> 하지만 `innodb_lock_wait_timeout` 시스템 변수를 활성화하면 이런 데드락 상황에서 일정 시간이 지나면 자동으로 요청이 실패하고 에러 메시지를 반환하게 된다.  
> `innodb_lock_wait_timeout` 은 초 단위로 설정할 수 있으며, `innodb_deadlock_detect` 를 OFF 로 설정해서 비활성화하는 경우라면 `innodb_lock_wait_timeout`을
> 기본값인 50초보다 훨씬 낮은 시간으로 변경해서 사용할 것을 권장한다.  

### InnoDB 버퍼풀
> InnoDB 스토리지 엔진에서 가장 핵심적인 부분으로, 디스크의 데이터 파일이나 인덱스 정보를 메모리에 캐시해 두는 공간이다.  
> MySQL 5.7 버전 이후로는 InnoDB 버퍼 풀의 크기를 동적으로 조절할 수 있게 개선됐다.  
> 처음으로 MySQL 서버를 준비한다면 다음과 같은 방법으로 InnoDB 버퍼 풀 설정을 찾아가는 방법을 권장한다.  
> 전체 메모리 공간이 8GB 미만이라면 50% 정도인 4GB 만 InnoDB 버퍼 풀로 설정하고 나머지 메모리 공간은 MySQL 서버와 운영체제, 
> 그리고 다른 프로그램이 사용할 수 있는 공간으로 확보해주는 것이 좋다.  
> 전제 메모리 공간이 8GB 이상이라면 InnoDB 버퍼 풀의 크기를 전체 메모리의 50% 에서 시작해서 조금씩 올려가면서 최적점을 찾는다.  
>
> 버퍼 풀 크기 확인 쿼리
> ```sql
> show variables where variable_name in ('innodb_buffer_pool_size', 'innodb_buffer_pool_instances');
> ```
> 
> InnoDB 버퍼 풀의 크기는 동적으로 변경할 수 있지만 버퍼 풀의 변경은 크리티컬한 변경이므로 가능하면 MySQL 서버가 한가한 시점을 골라서 진행하는 것이 좋다.  
> 또한 버퍼 풀을 더 크게 변경하는 작업은 시스템 영향도가 크지 않지만, 버퍼 풀의 크기를 줄이는 작업은 서비스 영향도가 매우 크므로 가능하면 버퍼 풀의 크기를 줄이는 
> 작업은 하지 않도록 주의하자.  
> 
> InnoDB 버퍼 풀은 전통적으로 버퍼 풀 전체를 관리하는 잠금(세마포어)으로 인해 내부 잠금 경합을 많이 유발해왔는데, 이런 경합을 줄이기 위해
> 버퍼 풀을 여러 개로 쪼개어 관리할 수 있게 개선됐다.  
> `innodb_buffer_pool_instances` 시스템 변수를 이용해 버퍼 풀을 여러 개로 분리해서 관리할 수 있는데, 각 버퍼 풀을 버퍼 풀 인스턴스라고 표현한다.  
> 기본적으로 버퍼 풀 인스턴스의 개수는 8개로 초기화되지만 전체 버퍼 풀을 위한 메모리 크기가 1GB 미만이면 버퍼풀 인스턴스는 1개만 생성된다.  
> 버퍼 풀로 할당할 수 있는 메모리 공간이 40GB 이하 수준이라면 기본 값인 8을 유지하고, 메모리가 크다면 버퍼 풀 인스턴스랑 5GB 정도가 되게 인스턴스 개수를 설정하는 것이 좋다.  

### 버퍼 풀과 리두 로그
> 버퍼 풀은 서버의 성능 향상을 위한 데이터 캐시 및 쓰기가 필요한 레코드들을 모아 한꺼번에 디스크에 적용하는 쓰기 버퍼링 두가지를 제공한다.  
> InnoDB 의 버퍼 풀은 디스크에서 읽은 상태로 전혀 변경되지 않은 클린 페이지와 함께 INSERT, UPDATE, DELETE 명령으로 변경된 데이터를 가진 더티 페이지(Dirty Page)도 가지고 있다.  
> 
> InnoDB 스토리지 엔진은 주기적으로 체크포인트 이벤트를 발생시켜 리두 로그와 버퍼 풀의 더티 페이지를 디스크로 동기화한다.
> 리두 로그의 공간이 모두 차게되면 체크포인트 이벤트가 발생한다.  
> 
> 리두 로그 파일 사이즈 확인 쿼리  
> ```sql
> show variables where variable_name = 'innodb_redo_log_capacity';
> ```
> Mysql 공식문서를 보면 리두 로그 파일을 버퍼풀 크기만큼 크게 만들라고 한다.  
> redo 로그 파일을 버퍼 풀만큼 크게 만듭니다.  
> InnoDB가 redo 로그 파일을 가득 채운 경우, 버퍼 풀의 수정된 내용을 체크포인트에서 디스크에 기록해야 합니다.  
> redo 로그 파일이 작을 경우 불필요한 디스크 쓰기가 많이 발생합니다.  
> 과거에는 대규모 redo 로그 파일이 복구 시간을 오래 끌었지만 이제는 복구 속도가 훨씬 빨라져 대용량 redo 로그 파일을 안심하고 사용할 수 있습니다.  
> 
> 로그 버퍼는 는 디스크의 리두 로그파일에 기록될 데이터를 보유하는 메모리 영역이다.  
> 로그 버퍼의 크기는 innodb_log_buffer_size 변수로 설정할수 있다. (일반적으로 4MB ~ 16MB 가 좋은 크기라고 한다)  
> 로그 버퍼크기를 크게 조정하면 트랜잭션을 커밋 하기 전에 디스크에 로그를 쓰지않아도 큰 트랜잭션을 실행할수 있다.  
> 많은 행을 업데이트, 삽입, 삭제하는 트랜잭션이 있는 경우 로그버퍼를 크게조정하면 DISK I/O 가 절약된다.  
> ```sql
> show variables where variable_name = 'innodb_log_buffer_size';
> ```
> 
> `innodb_page_cleaners` 는 `innodb_buffer_pool_instances` 와 갯수를 맞춘다.  
> 
> `innodb_io_capacity`, `innodb_io_capacity_max` 는 InnoDB 버퍼풀이 디스크를 읽고 쓰는 경우 속도를 의미한다. 디스크 IOPS 속도이며,
> 적절한 값은 운영을 통해서 알아가야하며, 디폴트는 각각 200, 2000 이다.

### 참조사이트
> [Mysql Redo Log 란](https://dus815.tistory.com/entry/Mysql-Redo-Log-란)

### 어댑티브 해시 인덱스
> 어댑티브 해시 인덱스는 InnoDB 스토리지 엔진에서 사용자가 자주 요청하는 데이터에 대해 자동으로 생성하는 인덱스이며,
> `innodb_adaptive_hash_index` 시스템 변수를 이용해서 활성화하거나 비활성화 할 수 있다.  
> 
> 어댑티브 해시 인덱스는 해시 기능을 통해서 B-Tree 인덱싱보다 좋은 성능 및 CPU 사용률을 줄여준다.   
> 
> 어댑티브 해시 인덱스는 InnoDB 버퍼풀(RAM 메모리)에 있는 데이터에 대해서만 인덱스를 생성하기 때문에 디스크 읽기가 많은 경우 등 상황에서 효용이 없을 수 있다.  
> MySQL 서버의 기본 설정은 어댑티브 해시 인덱스를 사용하도록 되어 있다.  
> 
> 어댑티브 해시 인덱스는 테이블의 삭제 및 스키마 수정 작업에 많은 영향을 미친다. 테이블의 삭제/변경 따라 인덱스의 삭제/변경 해야하기 때문이다.  
> 따라서 어댑티브 해시 인덱스가 `ALGORITHM=INSTANT` 를 사용해서 Online DDL 을 사용하는 경우에 상당한 시간을 소요시킬 수 있다.  
> 
> ```sql
> SHOW ENGINE INNODB STATUS \G
> ...
> -------------------------------------
> INSERT BUFFER AND ADAPTIVE HASH INDEX
> -------------------------------------
> ...
> 1.03 hash searches/s, 2.64 non-hash searches/s
> ```
> 위의 쿼리로 조회 쿼리 사용시 어댑티브 해시 인덱스 사용률을 알 수 있다. 여기서는 총 3.67(1.03 + 2.64) 중 1.03 번의 해시 인덱스 사용으로
> 28% 의 사용률을 알 수 있다.  
> 이 서버의 CPU 사용량이 100% 라는 가정하에 28% 의 인덱스 사용률을 보였다면 사용하는 것이 좋지만, CPU 사용량이 높지 않은 상태에서 28% 라면
> 어댑티브 해시 인덱스를 비활성화하는 편이 나을 수 있다.  

### 기타 엔진
> Memory 스토리지 엔진은 테이블 수준의 락만 지원하기 때문에 동시 처리에서 InnoDB 엔진보다 성능이 좋지 않다.  
> Memory 스토리지 엔진과 MyISAM 스토리지 엔진의 경우 하위 호환성을 위해서 유지하는 것으로 보이며 InnoDB 와 비교해서 장점이 없다.  
> 그래서 차후 버전에서는 제거될 것으로 예상된다.  

### 제너럴 쿼리 로그 파일
> MySQL 서버에서 실행된 쿼리 목록을 저장한 로그 파일  
> 로그 파일 위치 확인
> ```sql
> show variables where variable_name = 'general_log_file';
> ```

### 슬로우 쿼리 로그
> `long_query_time` 시스템 변수에 설정한 초 이상의 시간이 걸린 쿼리를 저장하는 로그  
> 반드시 쿼리가 정상적으로 실행이 완료되어야 기록된다.  
>
> ```sql
> # 슬로우 쿼리 임계 시간 확인(초)
> show variables where variable_name = 'long_query_time';
>
> # 슬로우 쿼리 로그 파일 위치 확인
> show variables where variable_name = 'slow_query_log_file';
> ```

---

## Lock
### 메타데이터(metadata) 락
> 데이터베이스 객체(테이블이나 뷰 등)의 이름이나 구조를 변경하는 경우에 자동으로 획득되는 잠금이다. 메타데이터 락은 명시적으로 획득하거나 해제할 수 있는 것이 아니다.

### ALGORITHM=INSTANT
> 기존 테이블의 구조 변경 작업 중에는 메타데이터 락 및 테이블 락이 걸려서 해당 테이블의 구조의 변경이 완료되기 전까지는 데이터가 INSERT 되지않았다.   
> 하지만 테이블 변경 쿼리 뒤에 `,ALGORITHM=INSTANT` 를 붙이면 메타데이터 락 및 테이블 락 없이 테이블 구조의 변경이 진행되기 때문에 데이터 조회 및 INSERT 에 문제가 없다.    
> 
> 현재 ALGORITHM=INSTANT 이 지원하는 기능은 다음과 같다.  
> 1.테이블 RENAME  
> 2.칼럼의 Default 값 설정/삭제/변경  
> 3.ENUM, SET 타입에 값 추가  
> 4.신규 칼럼 추가(Default 값이 있어도 관계 없음)
>
> **참조사이트**  
> [MySQL 8.0.12 Online DDL 방식 추가 (INSTANT Algorithm)](https://m.blog.naver.com/seuis398/221375024684)  
> [MySQL/MariaDB, 테이블 락 최소화하여 변경하기](https://jsonobject.tistory.com/515)  

### 레코드 락(Record lock)
> 레코드 자체만을 잠그는 것을 레코드 락이라고 한다.  
> InnoDB 스토리지 엔진은 레코드 자체가 아니라 인덱스의 레코드를 잠근다는 특징이 있다.  
> InnoDB 에서는 보조 인덱스를 이용한 변경 작업은 넥스트 키락 또는 갭 락을 사용한다.  
> 키 또는 유니크 인덱스에 의한 변경 작업에서는 갭 락에 대해서는 잠그지 않고 레코드 자체에 대해서만 락을 건다.  
> 
> UPDATE 시 조건에 사용되는 컬럼 중에 인덱스가 걸린 컬럼이 있으면 해당 컬럼의 값에 해당하는 레코드는 모두 락이 걸린다.  
> 예를 들어 `update employee set hire_date=now() where first_name='jujin' and last_name='robert';` 쿼리문을 가정하자.  
> first_name 칼럼에는 인덱스가 걸려있으며 first_name='jujin' 에 해당하는 레코드가 30개라고 가정하자.  
> last_name 칼럼에는 인덱스가 걸려있지 않다.  
> first_name='jujin' and last_name='robert' 에 해당하는 레코드는 1개라고 가정하자.  
> 그럼 위의 update 쿼리를 실행한 경우 first_name='jujin' and last_name='robert' 에 해당하는 레코드는 1개이기 때문에 해당 레코드만 락이 걸릴거 같다.  
> 하지만 first_name 에만 인덱스가 걸려있기 때문에 MySQL 은 first_name='jujin' 에 해당하는 레코드 30개를 모두 레코드 락을 건다.   
> 그리고 update 쿼리를 실행이 완료되면 30개의 레코드 락이 해제된다.
> 만약 employee 테이블에 인덱스가 하나도 없다면 테이블을 풀스캔하면서 update 작업을 하는데, 이 과정에서 테이블에 있는 모든 레코드를 잠그게 된다.  
> 이것이 MySQL 의 방식이며, MySQL 의 InnoDB 에서 인덱스 설계가 중요한 이유 또한 이것이다.  
> 왠만하면 겹치는 것이 없는 클러스터드 인덱스(PK) 를 사용하여 업데이트 하는 것이 Best 일 듯 싶다.  
> 혹은 보조 인덱스를 사용하더라도 대체키가 될 만한 컬럼의 보조인덱스를 사용해서 update 하는 것이 차선일 듯 싶다.  

### 갭 락(Gap lock)
> 갭 락은 레코드 자체가 아니라 레코드와 바로 인접한 레코드 사이의 간격만을 잠그는 것을 의미한다.  
> 갭 락의 역할은 레코드와 레코드 사이의 간격에 새로운 레코드가 생성(INSERT)되는 것을 제어하는 것이다.  
> 갭 락은 그 자체보다는 넥스트 키 락의 일부로 자주 사용된다.  

### 넥스트 키 락(Next key lock)
> InnoDB 의 갭 락이나 넥스트 키 락은 바이너리 로그에 기록되는 쿼리가 레플리카 서버에서 실행될 때 소스 서버에서 만들어 낸 결과와 동일한 결과를 만들어내도록 보장하는 것이 주목적이다.
> 그런데 의외로 넥스트 키 락과 갭 락으로 인해 데드락이 발생하거나 다른 트랜잭션을 기다리게 만드는 일이 자주 발생한다.  
> 가능하다면 바이너리 로그 포맷을 ROW 형태로 바꿔서 넥스트 키 락이나 갭락을 줄이는 것이 좋다.  
> 
> 바이너리 로그 포맷 확인 쿼리: `SELECT @@binlog_format;`  
> 바이너리 로그 포맷 설정: my.cnf 
> ```
> [mysqld]
> ...
> binlog_format=2   # binlog 포맷(0: MIXED, 1:STATEMENT, 2:ROW)
> ```

### 자동 증가 락(Auto increment lock)
> MySQL 에서는 자동 증가하는 숫자 값을 추출하기 위해 AUTO_INCREMENT 라는 칼럼 속성을 제공한다.  
> AUTO_INCREMENT 칼럼이 사용된 테이블에 동시에 여러 레코드가 INSERT 되는 경우, 저장되는 각 레코드는 중복되지 않고 저장된 순서대로 증가하는 일련번호 값을 가져아한다.  
> 이를 위해 InnoDB 스토리지 엔진에서는 내부적으로 AUTO_INCREMENT 락이라고 하는 테이블 수준의 잠금을 사용한다.  
> AUTO_INCREMENT 락은 INSERT, REPLACE 와 같이 새로운 레코드를 저장하는 쿼리에서만 동작한다.  
> AUTO_INCREMENT 락은 트랜잭션과 관계없이 AUTO_INCREMENT 값을 가져오는 순간만 락이 걸렸다가 즉시 해제된다.  
> 
> MySQL 5.1 이상부터는 `innodb_autoinc_lock_mode` 시스템 변수를 이용해 자동 증가 락의 작동 방식을 변경할 수 있다.  
> 자동 증가 락 모드 확인 쿼리: `show variables where variable_name = 'innodb_autoinc_lock_mode';`  
> 
> **innodb_autoinc_lock_mode=0**  
> MySQL 5.0 과 동일한 잠금 방식으로 모든 INSERT 문장은 자동 증가 락을 사용한다.  
> 
> **innodb_autoinc_lock_mode=1**  
> 단순히 한 건 또는 여러 건의 레코드를 INSERT 하는 SQL 중 MySQL 서버가 INSERT 되는 레코드 건수를 정확히 예측할 수 있을 때는 자동 증가 락을 
> 사용하지 않고, 훨씬 가볍고 빠른 래치(뮤택스)를 이용해 처리한다.  
> 개선된 래치는 자동 증가 락과 달리 아주 짧은 시간 동안만 잠금을 걸고 필요한 자동 증가 값을 가져오면 즉시 잠금이 해제된다.  
> 하지만 INSERT ... SELECT 와 같이 MySQL 서버가 쿼리를 실행하기 전에 건수를 예측할 수 없을 때는 MySQL 5.0 에서와 같이 자동 증가 락을 사용한다.  
> 
> **innodb_autoinc_lock_mode=2**  
> 절대 자동 증가 락을 걸지 않고 경량화된 래치(뮤택스)를 사용한다. 이 설정에서는 하나의 INSERT 문장으로 INSERT 되는 레코드라고 하더라도 연속된 자동 증가
> 값을 보장하지는 않는다.   
> 이 설정 모드에서는 INSERT ... SELECT 와 같은 대량 INSERT 문장이 실행되는 중에도 다른 커넥션에서 INSERT 를 수행할 수 있으므로 동시 처리 성능이
> 높아진다. 하지만 이 설정에서 작동하는 자동 증가 기능은 유니크한 값이 생성된다는 것만 보장한다.  
> STATEMENT 포맷의 바이너리 로그를 사용하는 복제에서는 소스 서버와 레플리카 서버의 자동 증가 값이 달라질 수도 있기 때문에 STATEMENT 포맷의 바이너리
> 로그를 사용한다면 innodb_autoinc_lock_mode=1 로 변경해서 사용할 것을 권장한다.  
> innodb_autoinc_lock_mode=2 는 바이너리 로그 포맷이 ROW 인 경우에만 사용을 권장한다.   

### 트랜잭션 격리 수준
> READ COMMITTED 격리 수준에서는 트랜잭션 내에서 실행되는 SELECT 문장과 트랜잭션 외부에서 실행되는 SELECT 문장의 차이가 별로 없다.  
> 하지만 REPEATABLE READ 격리 수준에서는 기본적으로 SELECT 쿼리 문장도 트랜잭션 범위 내에서만 작동한다. 즉, START TRANSACTION 명령으로 
> 트랜잭션을 시작한 상태에서 온종일 동일한 쿼리를 반복해서 실행해봐도 동일한 결과만 보게 된다.  

### MySQL 의 기본 트랜잭션 격리 수준
> REPEATABLE READ 는 MySQL 의 InnoDB 스토리지 엔진에서 기본으로 사용되는 격리 수준이다. 
> 바이너리 로그를 가진 MySQL 서버에서는 최소 REPEATABLE READ 격리 수준 이상을 사용해야 한다.  
> InnoDB 스토리지 엔진은 트랜잭션이 ROLLBACK 될 가능성에 대비해 변경되기 전 레코드를 언두(Undo) 공간에 백업해두고 실제 레코드 값을 변경한다. 
> 이러한 변경 방식을 MVCC 라고 한다.  
>
> 한 사용자가 BEGIN 으로 트랜잭션을 시작하고 장시간 트랜잭션을 종려하지 않으면 언두 영역이 백업된 데이터로 무한정 커질 수도 있다. 
> 이렇게 언두에 백업된 레코드가 많아지면 MySQL 서버의 처리 성능이 떨어질 수 있다.  
>
> InnoDB 스토리지 엔진에서는 갭 락과 넥스트 키 락 덕분에 REPEATABLE READ 격리 수준에서도 PHANTOM READ 가 발생하지 않는다.  

---

## 데이터 압축
### 테이블 압축 개요
> 증가하는 데이터로 인해서 서버의 저장공간이 부족 혹은 추가적인 HDD의 증설을 줄이려는 방법으로 데이터 수정(UPDATE)이 발생하지 않는 로그 테이블에 
> 적용하여 조회 속도 향상 및 저장 공간을 줄일 수 있는 기법. 
> 테이블 압축은 테이블 데이터를 압축해서 보관함으로 파일 I/O를 감소시키는 것이 가장 큰 목적입니다. (반대로 압축을 하게 되면 수정 시에는 속도가 느림)  

### 장단점
> 장점은 일반 테이블 보다 파일 크기를 줄일 수 있고, 데이터 조회 속도는 큰 차이가 없습니다.   
> 단점은 DML 수행 속도가 느려지며, 과거 데이터에 대한 관리 방법이 필요하다고 판단 합니다.  

### 내 의견
> 현재 내 의견은 로그의 경우에는 RDB 에 저장하는 것이 비용적으로 좋지 않다고 생각된다. 파일 혹은 NoSQL 고려가 필요할 듯 하다.  
> 로그가 아닌 수정이 발생하지 않는 테이블의 경우도 역시 마찬가지로 NoSQL 을 고려하는 것이 좋아보인다.  

### 참조사이트
> [[Admin] MariaDB/MySQL InnoDB 테이블 압축(Compression)](https://estenpark.tistory.com/377)

---

## 데이터 암호화
### MySQL 서버의 데이터 암호화
> MySQL 서버의 암호화 기능은 데이터베이스 서버와 디스크 사이의 데이터 읽고 쓰기 지점에서 암호화 또는 복호화를 수행한다.
> 그래서 MySQL 서버에서 데이터 입출력 이외의 부분에서는 암호화 처리가 전혀 필요치 않다. 즉, MySQL 서버(InnoDB 스토리지 엔진)의 I/O 레이어에서만
> 데이터의 암호화 및 복호화 과정이 실행되는 것이다.  
> 
> 데이터 암호화 기능이 활성화돼 있다고 하더라도 MySQL 내부와 사용자 입장에서는 아무런 차이가 없기 때문에 이러한 암호화 방식을 가리켜 TDE(Transparent Data Encryption)
> 이라고 한다.
 
### 2단계 키 관리
> MySQL 서버의 TDE 에서 암호화 키는 키링(KeyRing) 플러그인에 의해 관리되며, MySQL 8.0 버전에서 지원되는 키링 플러그인은 다음과 같다.  
> * keyring_file: File-Based 플러그인  
> * keyring_encrypted_file: Keyring 플러그인 (엔터프라이즈 에디션에서만 사용 가능)
> * keyring_okv: KMIP 플러그인 (엔터프라이즈 에디션에서만 사용 가능)
> * keyring_aws: Amazon Web Services Keyring 플러그인 (엔터프라이즈 에디션에서만 사용 가능)  
>
> 키링 플러그인은 2단계(2-Tier) 키 관리 방식을 사용한다.  
> 
> MySQL 서버의 데이터 암호화는 마스터 키(master key)와 테이블스페이스 키(tablespace key)라는 두 가지 종류의 키를 가지고 있다.  
> HashiCorp Vault 같은 외부 키 관리 솔루션(KMS: Key Management Service) 또는 디스크의 파일에서 마스터 키를 가져오고,
> 암호화된 테이블이 생성될 때마다 해당 테이블을 위한 임의의 테이블스페이스 키를 발급한다.  
> 
> 테이블스페이스 키는 절대 MySQL 서버 외부로 노출되지 않기 때문에 주기적으로 변경하지 않아도 보안상 취약점이 되지는 않는다.  
> 하지만 마스터 키는 외부의 파일을 이용하기 때문에 노출될 가능성이 있다. 그래서 마스터 키는 주기적으로 변경해야 한다.  
>
> 암호화된 테이블과 그렇지 않은 테이블의 디스크 읽고 쓰기에 걸리는 평균 시간을 비교해보면 다음과 같다.  
> 암호화된 테이블의 경우 읽기는 3~5배 정도 느리며, 쓰기의 경우 5~6배 정도 느린 것을 확인할 수 있다.  
> 물론 밀리초 단위이므로 수치가 워낙 낮은 편이어서 크게 체감되지는 않을 수도 있다.  
> 테이블의 크기가 206GB 임에도 읽기 속도가 평균 1.44 ms 이고 쓰기 속도가 평균 0.12 ms 가 나오기 때문에 일반적인 상황에서는 암호화로 인한 성능 저하를
> 크게 느끼기 힘들듯 싶다.  

### 암호화 테이블 생성
> TDE 를 이용하는 테이블은 다음과 같이 생성할 수 있다. 
> ```sql
> create table tab_encryted (
>   id bigint,
>   data varchar(100),
>   primary key(id)
> ) ENCRYPTION = 'Y';
> ```
> 
> 테이블을 생성할 때 마다 `ENCRYPTION = 'Y'` 를 설정하면 실수로 암호화 적용을 잊어버릴 수도 있다.  
> MySQL 서버의 모든 테이블에 대해 암호화를 적용하고자 한다면 `default_table_encryption` 시스템 변수를 ON 으로 설정하면
> `ENCRYPTION = 'Y'` 를 붙이지 않아도 암호화된 테이블로 생성된다.  
> default_table_encryption 확인 쿼리: `show variables where variable_name = 'default_table_encryption'`  

### 애플리케이션 레벨의 암호화와 차이점
> 애플리케이션 레벨에서 암호화를 하여 암호화한 데이터를 MySQL 에 INSERT 하게하는 방식이 존재한다.  
> 애플리케이션 레벨의 암호화를 사용하는 경우 동일 값을 찾는 이퀄 연산으로 데이터 조회가 가능하지만 범위 값을 사용하는 연산은 사용이 불가능하다.  
> MySQL 서버의 TDE 기능으로 암호화한다면 실행 중인 MySQL 서버에 로그인할 수 있다면 모든 데이터를 평문으로 확인할 수 있다.  

