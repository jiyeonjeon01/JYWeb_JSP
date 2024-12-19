-- 회원 관리 테이블
CREATE TABLE STUDENT (
    id         VARCHAR2(12) NOT NULL,         -- 사용자 ID (Primary Key)
    pass       VARCHAR2(12) NOT NULL,         -- 비밀번호
    name       VARCHAR2(10) NOT NULL,         -- 사용자 이름
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

-- 주소 관리 테이블
CREATE TABLE ZIPCODE (
    seq      NUMBER(10) PRIMARY KEY,          -- 우편번호 시퀀스 (Primary Key)
    zipcode  VARCHAR2(10) NOT NULL,           -- 우편번호
    sido     VARCHAR2(30),                    -- 시/도
    gugun    VARCHAR2(30),                    -- 구/군
    dong     VARCHAR2(50),                    -- 동/읍/면
    bunji    VARCHAR2(100)                    -- 번지
);

-- 통합 게시판 (NormalBoard)
CREATE TABLE NORMALBOARD (
    num         NUMBER(7,0) NOT NULL,         -- 게시글 번호 (Primary Key)
    board_type  VARCHAR2(10) NOT NULL,        -- 게시판 유형 (NOTI, NORMAL, SHOPPING)
    writer      VARCHAR2(20),                 -- 작성자 (STUDENT 테이블의 ID와 연결)
    title       VARCHAR2(50) NOT NULL,        -- 게시글 제목
    readcount   NUMBER(5,0) DEFAULT 0,        -- 조회수
    regdate     TIMESTAMP (6) DEFAULT SYSDATE, -- 작성일
    content     VARCHAR2(4000) NOT NULL,      -- 게시글 내용
    ip          VARCHAR2(45) NOT NULL,        -- 작성자 IP
    originfile  VARCHAR2(255),                -- 첨부파일 원본 파일명
    sysfile     VARCHAR2(255)                 -- 첨부파일 저장 파일명
);

ALTER TABLE NORMALBOARD ADD CONSTRAINT NORMALBOARD_NUM_PK PRIMARY KEY (num);
ALTER TABLE NORMALBOARD ADD CONSTRAINT NORMALBOARD_WRITER_FK FOREIGN KEY (writer)
    REFERENCES STUDENT (id);

CREATE SEQUENCE NORMALBOARD_SEQ START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;

-- 비로그인 질문 테이블 (LogoutBoard)
CREATE TABLE LOGOUTBOARD (
    num         NUMBER(7,0) NOT NULL,         -- 게시글 번호 (Primary Key)
    writer      VARCHAR2(20),                 -- 작성자 (STUDENT 테이블의 ID와 연결, 비로그인 사용자는 NULL 허용)
    email       VARCHAR2(30),                 -- 비로그인 사용자의 이메일
    pass        VARCHAR2(10),                 -- 비로그인 사용자의 비밀번호
    title       VARCHAR2(50) NOT NULL,        -- 게시글 제목
    readcount   NUMBER(5,0) DEFAULT 0,        -- 조회수
    regdate     TIMESTAMP (6) DEFAULT SYSDATE, -- 작성일
    content     VARCHAR2(4000) NOT NULL,      -- 게시글 내용
    ref         NUMBER(5,0) DEFAULT 0,        -- 그룹 번호 (질문글 그룹과 동일)
    step        NUMBER(3,0) DEFAULT 0,        -- 같은 그룹 내 순서
    depth       NUMBER(3,0) DEFAULT 0,        -- 계층 깊이
    ip          VARCHAR2(45) NOT NULL,        -- 작성자 IP
    originfile  VARCHAR2(255),                -- 첨부파일 원본 파일명
    sysfile     VARCHAR2(255)                 -- 첨부파일 저장 파일명
);
ALTER TABLE LOGOUTBOARD ADD CONSTRAINT LOGOUTBOARD_NUM_PK PRIMARY KEY (num);

CREATE SEQUENCE LOGOUTBOARD_SEQ START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;

-- 답변 테이블 (AnswerBoard)
CREATE TABLE ANSWERBOARD (
    num         NUMBER(7,0) NOT NULL,         -- 답변 번호 (Primary Key)
    qnum        NUMBER(7,0) NOT NULL,         -- 질문 번호 (LogoutQBoard의 NUM 참조)
    writer      VARCHAR2(20) NOT NULL,        -- 작성자 (STUDENT 테이블의 ID와 연결)
    title       VARCHAR2(50) NOT NULL,        -- 답변 제목
    readcount   NUMBER(5,0) DEFAULT 0,        -- 조회수
    ref         NUMBER(5,0) DEFAULT 0,        -- 그룹 번호 (질문글 그룹과 동일)
    step        NUMBER(3,0) DEFAULT 0,        -- 같은 그룹 내 순서
    depth       NUMBER(3,0) DEFAULT 0,        -- 계층 깊이
    regdate     TIMESTAMP (6) DEFAULT SYSDATE, -- 작성일
    content     VARCHAR2(4000) NOT NULL,      -- 답변 내용
    ip          VARCHAR2(45) NOT NULL,        -- 작성자 IP
    originfile  VARCHAR2(255),                -- 첨부파일 원본 파일명
    sysfile     VARCHAR2(255)                 -- 첨부파일 저장 파일명
);

ALTER TABLE ANSWERBOARD ADD CONSTRAINT ANSWERBOARD_NUM_PK PRIMARY KEY (num);
ALTER TABLE ANSWERBOARD ADD CONSTRAINT ANSWERBOARD_QNUM_FK FOREIGN KEY (qnum)
    REFERENCES LOGOUTBOARD (num) ON DELETE CASCADE;
ALTER TABLE ANSWERBOARD ADD CONSTRAINT ANSWERBOARD_WRITER_FK FOREIGN KEY (writer)
    REFERENCES STUDENT (id);

CREATE SEQUENCE ANSWERBOARD_SEQ START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;

-- 지금 짧은 시간 내에 하기에는 너무 과하다 맨 
---- 댓글 테이블 (NormalBoard 댓글)
--CREATE TABLE NORMALREPLY (
--    num         NUMBER(7,0) NOT NULL,         -- 댓글 번호 (Primary Key)
--    board_num   NUMBER(7,0) NOT NULL,         -- 게시글 번호 (NormalBoard의 NUM 참조)
--    writer      VARCHAR2(20) NOT NULL,        -- 작성자 (STUDENT 테이블의 ID와 연결)
--    content     VARCHAR2(1000) NOT NULL,      -- 댓글 내용
--    regdate     TIMESTAMP DEFAULT SYSDATE,    -- 작성일
--    ip          VARCHAR2(45) NOT NULL         -- 작성자 IP
--);
--
--ALTER TABLE NORMALREPLY ADD CONSTRAINT NORMALREPLY_PK PRIMARY KEY (num);
--ALTER TABLE NORMALREPLY ADD CONSTRAINT NORMALREPLY_BOARDNUM_FK FOREIGN KEY (board_num)
--    REFERENCES NORMALBOARD (num) ON DELETE CASCADE;
--ALTER TABLE NORMALREPLY ADD CONSTRAINT NORMALREPLY_WRITER_FK FOREIGN KEY (writer)
--    REFERENCES STUDENT (id);
--
--CREATE SEQUENCE NORMALREPLY_SEQ START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;

-- 장바구니 테이블
CREATE TABLE CART (
    cart_id    NUMBER(10) PRIMARY KEY,       -- 장바구니 ID
    user_id    VARCHAR2(12) NOT NULL,        -- 사용자 ID (STUDENT 테이블 참조)
    board_num    NUMBER(7,0) NOT NULL,         -- 상품 ID (NormalBoard 테이블 참조)
    quantity   NUMBER(3,0) DEFAULT 1        -- 수량
);

ALTER TABLE CART ADD CONSTRAINT CART_USER_FK FOREIGN KEY (user_id)
    REFERENCES STUDENT (id) ON DELETE CASCADE;
ALTER TABLE CART ADD CONSTRAINT CART_ITEM_FK FOREIGN KEY (board_num)
    REFERENCES NORMALBOARD (num) ON DELETE CASCADE;

CREATE SEQUENCE CART_SEQ START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;

COMMIT;

