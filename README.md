# 📖JYWeb_JSP
<p>
JSP로 만든 JYWeb. <br>
회원(어드민, 로그인, 비로그인 사용자), 글쓰기, 답변하기, 상품보기, 장바구니 담기 등의 기능이 담긴 커뮤니티 사이트이다
  
  ![image](https://github.com/user-attachments/assets/93b521e0-86ce-4ecd-9573-5a8a693b7626){: width="200"}

</p> 
<br>


## 👨‍👩‍👧‍👦 Member
<p>
  전지연 (본인)
</p>
<br>


## ⚙Tech Stack
<p><strong> Window: Windows11 <br></strong>
<br>
<img src="https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white">
</p>
<p><strong> Database: Oracle 21c <br></strong>
<br>
<img src="https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=Oracle&logoColor=white">
</p>
<p><strong> Repository <br></strong>
<br>
<img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white"> 
</p>
<p><strong> Software: 2024-09, jdk17.0.12 <br></strong>
<br>
<img src="https://img.shields.io/badge/Eclipse-2C2255?style=for-the-badge&logo=eclipse&logoColor=white">
</p>
<br>


## 🚩 Function
<p>
  <strong>(1) 사용자</strong> <br>
  1. 비로그인 사용자<br>
  2. 로그인 사용자(회원)<br>
  3. 어드민 
</p>
<p>
  <strong>(2) 회원가입 & 로그인 & 로그아웃</strong> <br>
  1. 회원가입(id 중복찾기, 우편번호 찾기) <br>
  2. 로그인 후 회원 정보 수정 기능 <br>
  3. 로그인 후 회원 탈퇴 기능  <br>
  4. 로그아웃 기능 <br>
</p>
<p>
  <strong>(3) 공지사항 게시판</strong> <br>
  1. 읽기 (비로그인, 회원, 어드민)<br>
  2. 쓰기, 수정, 삭제 (어드민)  <br>
</p>
<p>
  <strong>(4) 자유 게시판</strong> <br>
  1. 읽기 (비로그인, 회원, 어드민)<br>
  2. 쓰기 (회원, 어드민) <br>
  3. 수정, 삭제 (글을 쓴 본인(회원, 어드민), 어드민)<br>
  4. 답글 기능 (회원, 어드민)<br>
</p>
<p>
  <strong>(5) QNA 게시판</strong> <br>
  1. 읽기, 질문쓰기, 질문수정, 질문삭제 (비로그인, 회원, 어드민)<br>
  2. 질문수정, 질문삭제는 글을 쓴 본인(회원, 비회원, 어드민)과 어드민 가능 <br>
  3. 답변쓰기, 답변수정, 답변삭제 (어드민)<br>
</p>
<p>
  <strong>(6) 쇼핑하기</strong> <br>
  1. 상품보기 (비로그인, 회원, 어드민)<br>
  2. 상품 등록, 수정, 삭제 (어드민) <br>
  3. 장바구니에 담기 (회원, 어드민)<br>
</p>
<br>

## 🖥️Test
[구현 내용 동영상으로 확인하기](링크)
<br>


## 💾 Project Implementation
```sql
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
SELECT * FROM STUDENT;
UPDATE STUDENT SET role = 'ADMIN' WHERE id = 'admin';
UPDATE STUDENT SET role = 'ADMIN' WHERE id = 'jiyeon';


-- 주소 관리 테이블
CREATE TABLE ZIPCODE (
    seq      NUMBER(10) PRIMARY KEY,          -- 우편번호 시퀀스 (Primary Key)
    zipcode  VARCHAR2(10) NOT NULL,           -- 우편번호
    sido     VARCHAR2(30),                    -- 시/도
    gugun    VARCHAR2(30),                    -- 구/군
    dong     VARCHAR2(50),                    -- 동/읍/면
    bunji    VARCHAR2(100)                    -- 번지
);
SELECT * 
FROM ZIPCODE 
WHERE DONG LIKE '방배%';

-----------------------------------------------------------------------------------------

-- 로그인 게시판 (LoginBoard)
CREATE TABLE LOGINBOARD (
    num             NUMBER(7,0),                   -- 게시글 번호 (Primary Key)
    type            VARCHAR2(20) NOT NULL,         -- 게시판 유형 (NOTI, NORMAL, QUESTION, ANSWER, SHOPPING)
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
SELECT * FROM LOGINBOARD;


-- 비로그인 게시판 (LogoutBoard)
CREATE TABLE LOGOUTBOARD (
    num         NUMBER(7,0),                   -- 게시글 번호 (Primary Key)
    type        VARCHAR2(20) NOT NULL,         -- 게시판 유형 (QUESTION)
    writer      VARCHAR2(20),                  -- 작성자 ()
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
SELECT * FROM LOGOUTBOARD;

-- PRODUCT 테이블
CREATE TABLE PRODUCT (
    num             NUMBER(7, 0), -- pk   
    student_id      VARCHAR2(20),                  -- 작성자 (STUDENT 테이블의 ID와 연결)
    name            VARCHAR2(40) NOT NULL,
    price           NUMBER(15) NOT NULL,
    detail          VARCHAR2(300),
    originfile      VARCHAR2(255), -- 첨부파일 원본 파일명
    sysfile         VARCHAR2(255)  -- 첨부파일 저장 파일명
);
ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_NUM_PK PRIMARY KEY (num);
CREATE SEQUENCE PRODUCT_SEQ START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;
ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_STUDENTID_FK FOREIGN KEY (student_id)
    REFERENCES STUDENT (id);
SELECT * FROM PRODUCT;


-- CART 테이블 
CREATE TABLE CART (
    num                 NUMBER(10),        -- 장바구니 ID
    student_id          VARCHAR2(20) NOT NULL, -- 사용자 ID (STUDENT 테이블 참조)
    product_num         NUMBER(7,0) NOT NULL, -- 상품 ID (PRODUCT 테이블 참조)
    quantity            NUMBER(3,0) DEFAULT 1 -- 수량
);
ALTER TABLE CART ADD CONSTRAINT CART_ID_PK PRIMARY KEY(num);
ALTER TABLE CART ADD CONSTRAINT CART_STUDENTID_FK FOREIGN KEY (student_id)
    REFERENCES STUDENT (id) ON DELETE CASCADE;
ALTER TABLE CART ADD CONSTRAINT CART_PRODUCTNUM_FK FOREIGN KEY (product_num)
    REFERENCES PRODUCT (num) ON DELETE CASCADE;
CREATE SEQUENCE CART_SEQ START WITH 1 INCREMENT BY 1 NOMAXVALUE NOCACHE NOCYCLE;
SELECT * FROM CART;


COMMIT;

```

![image](https://github.com/user-attachments/assets/b0ed6715-63d4-4ddb-8a73-fcee13dc3fc7)




