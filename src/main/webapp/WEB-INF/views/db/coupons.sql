DROP SEQUENCE COUPONS_SEQ;
CREATE SEQUENCE COUPONS_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999
NOCYCLE
NOCACHE;

DROP TABLE COUPONS;
CREATE TABLE COUPONS(                                -- 쿠폰테이블
    C_NO NUMBER PRIMARY KEY,                         -- 쿠폰넘버링
    C_NAME VARCHAR2(200) NOT NULL,                   -- 쿠폰명
    C_DISCOUNT NUMBER,                               -- 쿠폰할인율
    C_PRICE NUMBER,                                  -- 쿠폰고정할인가격
    C_REGDATE DATE NOT NULL,                         -- 쿠폰 생성일
    C_STARTDATE DATE,                                -- 쿠폰 시작일자
    C_ENDDATE DATE,                                  -- 쿠폰 만료일자
    C_M_ID VARCHAR2(50),                             -- 쿠폰소유 사용자 아이디
    C_P_NO NUMBER,                                   -- 쿠폰적용 대상품목
    FOREIGN KEY (C_M_ID) REFERENCES MEMBERS (M_ID),
    FOREIGN KEY (C_P_NO) REFERENCES PRODUCTS (P_NO)
);

INSERT INTO COUPONS VALUES(COUPONS_SEQ.NEXTVAL,'생일할인',15,3000,'2021/01/22','2021/01/22','2022/01/22','USER1',1);
INSERT INTO COUPONS VALUES(COUPONS_SEQ.NEXTVAL,'블랙프라이데이할인',10,2000,'2021/01/10','2021/01/10','2022/01/22','USER2',2);
INSERT INTO COUPONS VALUES(COUPONS_SEQ.NEXTVAL,'신규가입할인',15,2000,'2021/01/25','2021/01/25','2022/01/27','USER3',3);
INSERT INTO COUPONS VALUES(COUPONS_SEQ.NEXTVAL,'가입추천할인',10,2000,'2021/01/24','2021/01/24','2022/01/24','USER4',4);
INSERT INTO COUPONS VALUES(COUPONS_SEQ.NEXTVAL,'깜짝할인',10,2000,'2021/01/22','2021/01/25','2022/01/27','USER5',5);