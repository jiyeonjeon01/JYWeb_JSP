-- 회원 관리 테이블
CREATE TABLE STUDENT (
    id         VARCHAR2(20),                  -- 사용자 ID (Primary Key)
    pass       VARCHAR2(30) NOT NULL,         -- 비밀번호
    name       VARCHAR2(30) NOT NULL,         -- 사용자 이름
    phone1     VARCHAR2(3) NOT NULL,          -- 전화번호 앞자리
    phone2     VARCHAR2(4) NOT NULL,          -- 전화번호 중간자리
    phone3     VARCHAR2(4) NOT NULL,          -- 전화번호 뒷자리
    email      VARCHAR2(30) NOT NULL,         -- 이메일
    zipcode    VARCHAR2(7) NOT NULL,          -- 우편번호
    address1   VARCHAR2(120) NOT NULL,        -- 주소 (기본)
    address2   VARCHAR2(50) NOT NULL,         -- 주소 (상세)
    originfile VARCHAR2(255),                 -- 프로필 사진 원본 파일명
    sysfile    VARCHAR2(255),                 -- 프로필 사진 저장 파일명
    role       VARCHAR2(10) DEFAULT 'USER' NOT NULL, -- 사용자 역할 (USER/ADMIN)
    CONSTRAINT student_role_ck CHECK (role IN ('USER', 'ADMIN')) -- Role 제한
);
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_ID_PK PRIMARY KEY (id);
SELECT COUNT(*) AS count FROM STUDENT WHERE ID = 'AAA';

-- 주소 관리 테이블
CREATE TABLE ZIPCODE (
    seq      NUMBER(10) PRIMARY KEY,          -- 우편번호 시퀀스 (Primary Key)
    zipcode  VARCHAR2(10) NOT NULL,           -- 우편번호
    sido     VARCHAR2(30),                    -- 시/도
    gugun    VARCHAR2(30),                    -- 구/군
    dong     VARCHAR2(50),                    -- 동/읍/면
    bunji    VARCHAR2(100)                    -- 번지
);

-----------------------------------------------------------------------------------------

-- 로그인 게시판 (LoginBoard)
CREATE TABLE LOGINBOARD (
    num             NUMBER(7,0),                   -- 게시글 번호 (Primary Key)
    type            VARCHAR2(20) NOT NULL,         -- 게시판 유형 (NOTI, NORMAL, SHOPPING)
    student_id      VARCHAR2(20),                  -- 작성자 (STUDENT 테이블의 ID와 연결)
    title           VARCHAR2(100) NOT NULL,        -- 게시글 제목
    readcount       NUMBER(5,0) DEFAULT 0,         -- 조회수
    regdate         TIMESTAMP (6) DEFAULT SYSDATE, -- 작성일
    content         VARCHAR2(4000) NOT NULL,       -- 게시글 내용
    ref             NUMBER(5,0) DEFAULT 0,         -- 그룹 번호 (질문글 그룹과 동일)
    step            NUMBER(3,0) DEFAULT 0,         -- 같은 그룹 내 순서
    depth           NUMBER(3,0) DEFAULT 0,         -- 계층 깊이
    ip              VARCHAR2(45) NOT NULL,         -- 작성자 IP
    originfile      VARCHAR2(255),                 -- 첨부파일 원본 파일명
    sysfile         VARCHAR2(255)                  -- 첨부파일 저장 파일명
);
ALTER TABLE LOGINBOARD ADD CONSTRAINT LOGINBOARD_NUM_PK PRIMARY KEY (num);
ALTER TABLE LOGINBOARD ADD CONSTRAINT LOGINBOARD_STUDENTID_FK FOREIGN KEY (student_id)
    REFERENCES STUDENT (id);
CREATE SEQUENCE LOGINBOARD_SEQ START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;


-- 비로그인 게시판 (LogoutBoard)
CREATE TABLE LOGOUTBOARD (
    num         NUMBER(7,0),                   -- 게시글 번호 (Primary Key)
    writer      VARCHAR2(20),                  -- 작성자 (STUDENT 테이블의 ID와 연결, 비로그인 사용자는 NULL 허용)
    email       VARCHAR2(50),                  -- 비로그인 사용자의 이메일
    pass        VARCHAR2(30),                  -- 비로그인 사용자의 비밀번호
    title       VARCHAR2(100) NOT NULL,         -- 게시글 제목
    readcount   NUMBER(5,0) DEFAULT 0,         -- 조회수
    regdate     TIMESTAMP (6) DEFAULT SYSDATE, -- 작성일
    content     VARCHAR2(4000) NOT NULL,       -- 게시글 내용
    ref         NUMBER(5,0) DEFAULT 0,         -- 그룹 번호 (질문글 그룹과 동일)
    step        NUMBER(3,0) DEFAULT 0,         -- 같은 그룹 내 순서
    depth       NUMBER(3,0) DEFAULT 0,         -- 계층 깊이
    ip          VARCHAR2(45) NOT NULL,         -- 작성자 IP
    originfile  VARCHAR2(255),                 -- 첨부파일 원본 파일명
    sysfile     VARCHAR2(255)                  -- 첨부파일 저장 파일명
);
ALTER TABLE LOGOUTBOARD ADD CONSTRAINT LOGOUTBOARD_NUM_PK PRIMARY KEY (num);
CREATE SEQUENCE LOGOUTBOARD_SEQ START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;


-- 장바구니 테이블
CREATE TABLE CART (
    id                  NUMBER(10),        -- 장바구니 ID
    student_id          VARCHAR2(20) NOT NULL,         -- 사용자 ID (STUDENT 테이블 참조)
    loginboard_num      NUMBER(7,0) NOT NULL,         -- 상품 ID (NormalBoard 테이블 참조)
    quantity            NUMBER(3,0) DEFAULT 100          -- 수량
);
ALTER TABLE CART ADD CONSTRAINT CART_ID_PK PRIMARY KEY(id);
ALTER TABLE CART ADD CONSTRAINT CART_STUDENTID_FK FOREIGN KEY (student_id)
    REFERENCES STUDENT (id) ON DELETE CASCADE;
ALTER TABLE CART ADD CONSTRAINT CART_LOGINBOARDNUM_FK FOREIGN KEY (loginboard_num)
    REFERENCES LOGINBOARD (num) ON DELETE CASCADE;
CREATE SEQUENCE CART_SEQ START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;


COMMIT;

SELECT column_name, data_type, data_length, nullable
FROM user_tab_columns
WHERE table_name = 'STUDENT';
SELECT column_name, data_type, data_length, nullable
FROM user_tab_columns
WHERE table_name = 'ZIPCODE';
SELECT column_name, data_type, data_length, nullable
FROM user_tab_columns
WHERE table_name = 'LOGINBOARD';
SELECT column_name, data_type, data_length, nullable
FROM user_tab_columns
WHERE table_name = 'LOGOUTBOARD';
SELECT column_name, data_type, data_length, nullable
FROM user_tab_columns
WHERE table_name = 'CART';



--
---- 제약조건 삭제
--ALTER TABLE CART DROP CONSTRAINT CART_ID_PK;
--ALTER TABLE CART DROP CONSTRAINT CART_STUDENTID_FK;
--ALTER TABLE CART DROP CONSTRAINT CART_LOGINBOARDNUM_FK;
--
--ALTER TABLE LOGINBOARD DROP CONSTRAINT LOGINBOARD_NUM_PK;
--ALTER TABLE LOGINBOARD DROP CONSTRAINT LOGINBOARD_STUDENTID_FK;
--
--ALTER TABLE LOGOUTBOARD DROP CONSTRAINT LOGOUTBOARD_NUM_PK;
--
--ALTER TABLE STUDENT DROP CONSTRAINT STUDENT_ID_PK;
--ALTER TABLE STUDENT DROP CONSTRAINT STUDENT_ROLE_CK;
--
---- 테이블 삭제
--DROP TABLE CART PURGE;
--DROP TABLE LOGINBOARD PURGE;
--DROP TABLE LOGOUTBOARD PURGE;
--DROP TABLE STUDENT PURGE;
--
---- 시퀀스 삭제
--DROP SEQUENCE CART_SEQ;
--DROP SEQUENCE LOGINBOARD_SEQ;
--DROP SEQUENCE LOGOUTBOARD_SEQ;
--
--COMMIT;
