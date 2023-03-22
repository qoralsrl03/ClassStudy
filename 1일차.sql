--1일차 주석
/*mysql은 써봤지만 oracle은 어떻게 쓰는지 모르곘다*/
-- 테이블 스페이스 생성 --
create tablespace myts
datafile '/u01/app/oracle/oradata/XE/myts.dbf'
SIZE 100M autoextend on next 5M;

-- 유저 생성
create user java identified by oracle
default tablespace myts
temporary tablespace temp;

--권한 설정--
grant resource, connect to java;

select tablespace_name from dba_tablespaces;
