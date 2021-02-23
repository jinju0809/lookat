-- DROP TABLE PRODUCT CASCADE CONSTRAINTS;

-- SELECT * FROM PRODUCT;

DROP SEQUENCE PRODUCT_SEQ;
CREATE SEQUENCE PRODUCT_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999
NOCYCLE
NOCACHE;

DROP TABLE PRODUCT;
CREATE TABLE PRODUCT(						-- 제품테이블
	IDX NUMBER NOT NULL,					-- 제품인덱스 (같은제품 사이즈 같으면 같은 번호입니다.)
    P_NO NUMBER PRIMARY KEY,				-- 제품번호
    P_NAME VARCHAR2(200) NOT NULL,			-- 제품명
    P_SIZE VARCHAR2(50) NOT NULL,			-- 제품size(ex: S, M ,L)
    P_PRICE NUMBER NOT NULL,				-- 제품가격
    P_COLOR VARCHAR2(30),					-- 제품색상
    P_AMOUNT NUMBER NOT NULL,				-- 제품수량
    P_REGDATE DATE,							-- 제품등록일
	P_CATEGORY VARCHAR2(50) NOT NULL,		-- 제품카테고리
	P_IMAGE VARCHAR2(200),					-- 제품사진
	P_FABRIC VARCHAR2(200),					-- 제품섬유정보
	P_INFORMATION VARCHAR2(1000)			-- 제품정보
);
-- P_SEASON 제품시즌

-- INSERT --
INSERT INTO PRODUCT VALUES(0,0,' ',' ',0,NULL,0,SYSDATE,' ',NULL,NULL,NULL);

-- OUTER --
INSERT INTO PRODUCT VALUES(1,PRODUCT_SEQ.NEXTVAL,'HALF DOUBLE LONG COAT','S',288000,'CHARCOAL',10,SYSDATE,'OUTER','resources/storage/p_01_HALF%20DOUBLE%20LONG%20COAT%20%5BCHARCOAL%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(1,PRODUCT_SEQ.NEXTVAL,'HALF DOUBLE LONG COAT','M',288000,'CHARCOAL',10,SYSDATE,'OUTER','resources/storage/p_01_HALF%20DOUBLE%20LONG%20COAT%20%5BCHARCOAL%5D.jpg','','');
INSERT INTO PRODUCT VALUES(1,PRODUCT_SEQ.NEXTVAL,'HALF DOUBLE LONG COAT','L',288000,'CHARCOAL',10,SYSDATE,'OUTER','resources/storage/p_01_HALF%20DOUBLE%20LONG%20COAT%20%5BCHARCOAL%5D.jpg','','');

INSERT INTO PRODUCT VALUES(2,PRODUCT_SEQ.NEXTVAL,'HALF DOUBLE LONG COAT','S',288000,'NAVY',10,SYSDATE,'OUTER','resources/storage/p_02_HALF%20DOUBLE%20LONG%20COAT%20%5BNAVY%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(2,PRODUCT_SEQ.NEXTVAL,'HALF DOUBLE LONG COAT','M',288000,'NAVY',10,SYSDATE,'OUTER','resources/storage/p_02_HALF%20DOUBLE%20LONG%20COAT%20%5BNAVY%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(2,PRODUCT_SEQ.NEXTVAL,'HALF DOUBLE LONG COAT','L',288000,'NAVY',10,SYSDATE,'OUTER','resources/storage/p_02_HALF%20DOUBLE%20LONG%20COAT%20%5BNAVY%5D.jpg','','');

INSERT INTO PRODUCT VALUES(3,PRODUCT_SEQ.NEXTVAL,'OUT POCKET PEA COAT','S',268000,'HERRINGBONE',10,SYSDATE,'OUTER','resources/storage/p_03_OUT%20POCKET%20PEA%20COAT%20%5BHERRINGBONE%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(3,PRODUCT_SEQ.NEXTVAL,'OUT POCKET PEA COAT','M',268000,'HERRINGBONE',10,SYSDATE,'OUTER','resources/storage/p_03_OUT%20POCKET%20PEA%20COAT%20%5BHERRINGBONE%5D.jpg','','');
INSERT INTO PRODUCT VALUES(3,PRODUCT_SEQ.NEXTVAL,'OUT POCKET PEA COAT','L',268000,'HERRINGBONE',10,SYSDATE,'OUTER','resources/storage/p_03_OUT%20POCKET%20PEA%20COAT%20%5BHERRINGBONE%5D.jpg','','');

INSERT INTO PRODUCT VALUES(4,PRODUCT_SEQ.NEXTVAL,'OUT POCKET PEA COAT','S',268000,'NAVY',10,SYSDATE,'OUTER','resources/storage/p_04_OUT%20POCKET%20PEA%20COAT%20%5BNAVY%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(4,PRODUCT_SEQ.NEXTVAL,'OUT POCKET PEA COAT','M',268000,'NAVY',10,SYSDATE,'OUTER','resources/storage/p_04_OUT%20POCKET%20PEA%20COAT%20%5BNAVY%5D.jpg','','');

INSERT INTO PRODUCT VALUES(5,PRODUCT_SEQ.NEXTVAL,'WOOL MAXI-OVER MAC COAT','S',288000,'CHARCOAL CHECK',10,SYSDATE,'OUTER','resources/storage/p_05_WOOL%20MAXI-OVER%20MAC%20COAT%20%5BCHARCOAL%20CHECK%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(5,PRODUCT_SEQ.NEXTVAL,'WOOL MAXI-OVER MAC COAT','M',288000,'CHARCOAL CHECK',10,SYSDATE,'OUTER','resources/storage/p_05_WOOL%20MAXI-OVER%20MAC%20COAT%20%5BCHARCOAL%20CHECK%5D.jpg','','');
INSERT INTO PRODUCT VALUES(5,PRODUCT_SEQ.NEXTVAL,'WOOL MAXI-OVER MAC COAT','L',288000,'CHARCOAL CHECK',10,SYSDATE,'OUTER','resources/storage/p_05_WOOL%20MAXI-OVER%20MAC%20COAT%20%5BCHARCOAL%20CHECK%5D.jpg','','');

INSERT INTO PRODUCT VALUES(6,PRODUCT_SEQ.NEXTVAL,'SEMI-OVER MARSEILE DOUBLE JACKET','S',258000,'CHARCOAL CHECK',10,SYSDATE,'OUTER','resources/storage/p_06_SEMI-OVER%20MARSEILE%20DOUBLE%20JACKET%20%5BCHARCOAL%20CHECK%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(6,PRODUCT_SEQ.NEXTVAL,'SEMI-OVER MARSEILE DOUBLE JACKET','M',258000,'CHARCOAL CHECK',10,SYSDATE,'OUTER','resources/storage/p_06_SEMI-OVER%20MARSEILE%20DOUBLE%20JACKET%20%5BCHARCOAL%20CHECK%5D.jpg','','');
INSERT INTO PRODUCT VALUES(6,PRODUCT_SEQ.NEXTVAL,'SEMI-OVER MARSEILE DOUBLE JACKET','L',258000,'CHARCOAL CHECK',10,SYSDATE,'OUTER','resources/storage/p_06_SEMI-OVER%20MARSEILE%20DOUBLE%20JACKET%20%5BCHARCOAL%20CHECK%5D.jpg','','');

INSERT INTO PRODUCT VALUES(7,PRODUCT_SEQ.NEXTVAL,'SEMI-OVER MARSEILE DOUBLE JACKET','S',258000,'AQUA MARINE',10,SYSDATE,'OUTER','resources/storage/p_07_SEMI-OVER%20MARSEILE%20DOUBLE%20JACKET%20%5BAQUA%20MARINE%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN', '일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다.
롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(7,PRODUCT_SEQ.NEXTVAL,'SEMI-OVER MARSEILE DOUBLE JACKET','M',258000,'AQUA MARINE',10,SYSDATE,'OUTER','resources/storage/p_07_SEMI-OVER%20MARSEILE%20DOUBLE%20JACKET%20%5BAQUA%20MARINE%5D.jpg','','');
INSERT INTO PRODUCT VALUES(7,PRODUCT_SEQ.NEXTVAL,'SEMI-OVER MARSEILE DOUBLE JACKET','L',258000,'AQUA MARINE',10,SYSDATE,'OUTER','resources/storage/p_07_SEMI-OVER%20MARSEILE%20DOUBLE%20JACKET%20%5BAQUA%20MARINE%5D.jpg','','');

INSERT INTO PRODUCT VALUES(8,PRODUCT_SEQ.NEXTVAL,'Military Over Coat','S',368000,'Herringbone',10,SYSDATE,'OUTER','resources/storage/p_08_Military%20Over%20Coat%20%5BHerringbone%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(8,PRODUCT_SEQ.NEXTVAL,'Military Over Coat','M',368000,'Herringbone',10,SYSDATE,'OUTER','resources/storage/p_08_Military%20Over%20Coat%20%5BHerringbone%5D.jpg','','');
INSERT INTO PRODUCT VALUES(8,PRODUCT_SEQ.NEXTVAL,'Military Over Coat','L',368000,'Herringbone',10,SYSDATE,'OUTER','resources/storage/p_08_Military%20Over%20Coat%20%5BHerringbone%5D.jpg','','');

INSERT INTO PRODUCT VALUES(9,PRODUCT_SEQ.NEXTVAL,'909 Single Jacket','S',148000,'Black',10,SYSDATE,'OUTER','resources/storage/p_09_909%20Single%20Jacket%20%5BBlack%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(9,PRODUCT_SEQ.NEXTVAL,'909 Single Jacket','M',148000,'Black',10,SYSDATE,'OUTER','resources/storage/p_09_909%20Single%20Jacket%20%5BBlack%5D.jpg','','');
INSERT INTO PRODUCT VALUES(9,PRODUCT_SEQ.NEXTVAL,'909 Single Jacket','L',148000,'Black',10,SYSDATE,'OUTER','resources/storage/p_09_909%20Single%20Jacket%20%5BBlack%5D.jpg','','');

-- BOTTOM --
INSERT INTO PRODUCT VALUES(10,PRODUCT_SEQ.NEXTVAL,'20SS_Technical Semi-Wide slacks[wool blend]','S',119000,'BLACK',10,SYSDATE,'BOTTOM','resources/storage/p_10_20SS_Technical%20Semi-Wide%20slacks%5Bwool%20blend%5D%20%5BBLACK%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(10,PRODUCT_SEQ.NEXTVAL,'20SS_Technical Semi-Wide slacks[wool blend]','M',119000,'BLACK',10,SYSDATE,'BOTTOM','resources/storage/p_10_20SS_Technical%20Semi-Wide%20slacks%5Bwool%20blend%5D%20%5BBLACK%5D.jpg','','');
INSERT INTO PRODUCT VALUES(10,PRODUCT_SEQ.NEXTVAL,'20SS_Technical Semi-Wide slacks[wool blend]','L',119000,'BLACK',10,SYSDATE,'BOTTOM','resources/storage/p_10_20SS_Technical%20Semi-Wide%20slacks%5Bwool%20blend%5D%20%5BBLACK%5D.jpg','','');

INSERT INTO PRODUCT VALUES(11,PRODUCT_SEQ.NEXTVAL,'NOAH Merino Wool One Tuck Pants','S',129000,'BLACK',10,SYSDATE,'BOTTOM','resources/storage/p_11_NOAH%20Merino%20Wool%20One%20Tuck%20Pants%20%5BBLACK%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(11,PRODUCT_SEQ.NEXTVAL,'NOAH Merino Wool One Tuck Pants','M',129000,'BLACK',10,SYSDATE,'BOTTOM','resources/storage/p_11_NOAH%20Merino%20Wool%20One%20Tuck%20Pants%20%5BBLACK%5D.jpg','','');
INSERT INTO PRODUCT VALUES(11,PRODUCT_SEQ.NEXTVAL,'NOAH Merino Wool One Tuck Pants','L',129000,'BLACK',10,SYSDATE,'BOTTOM','resources/storage/p_11_NOAH%20Merino%20Wool%20One%20Tuck%20Pants%20%5BBLACK%5D.jpg','','');

-- BAG --
INSERT INTO PRODUCT VALUES(12,PRODUCT_SEQ.NEXTVAL,'Saddle Mini-Bag [Eppi leather]','FREE',148000,'NAVY',0,SYSDATE,'BAG','resources/storage/p_12_Saddle%20Mini-Bag%20%5BEppi%20leather%5D%20%5BNAVY%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');

-- BLACKFRIDAY --
INSERT INTO PRODUCT VALUES(13,PRODUCT_SEQ.NEXTVAL,'20SS_Modern Half-Double Blazer [wool blend]','S',199000,'NAVY',0,SYSDATE,'BLACKFRIDAY','resources/storage/p_13_20SS_Modern%20Half-Double%20Blazer%20%5Bwool%20blend%5D%20%5BNAVY%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(13,PRODUCT_SEQ.NEXTVAL,'20SS_Modern Half-Double Blazer [wool blend]','M',199000,'DARK NAVY',0,SYSDATE,'BLACKFRIDAY','resources/storage/p_13_20SS_Modern%20Half-Double%20Blazer%20%5Bwool%20blend%5D%20%5BNAVY%5D.jpg','','');
INSERT INTO PRODUCT VALUES(13,PRODUCT_SEQ.NEXTVAL,'20SS_Modern Half-Double Blazer [wool blend]','L',199000,'NAVY',10,SYSDATE,'BLACKFRIDAY','resources/storage/p_13_20SS_Modern%20Half-Double%20Blazer%20%5Bwool%20blend%5D%20%5BNAVY%5D.jpg','','');

INSERT INTO PRODUCT VALUES(14,PRODUCT_SEQ.NEXTVAL,'20SS_New Collarless Blazer [wool blend]','S',199000,'BLACK',0,SYSDATE,'BLACKFRIDAY','resources/storage/p_14_20SS_New%20Collarless%20Blazer%20%5Bwool%20blend%5D%20%5BBLACK%5D.jpg',
'겉감 : WOOL 90% POLYAMIDE 10% 안감 : VISCOSE 43% POLY 57% 부자재 : REAL HORN',
'일자 오버핏으로 포멀하게 떨어지는 트렌디한 패턴을 적용하여 캐주얼하면서도 격식있게 연출 가능합니다. 롱한 기장감이지만 적당한 중량감과 두께감으로 한 겨울에도 착용가능합니다.');
INSERT INTO PRODUCT VALUES(14,PRODUCT_SEQ.NEXTVAL,'20SS_New Collarless Blazer [wool blend]','M',199000,'BLACK',10,SYSDATE,'BLACKFRIDAY','resources/storage/p_14_20SS_New%20Collarless%20Blazer%20%5Bwool%20blend%5D%20%5BBLACK%5D.jpg','','');
INSERT INTO PRODUCT VALUES(14,PRODUCT_SEQ.NEXTVAL,'20SS_New Collarless Blazer [wool blend]','L',199000,'BLACK',10,SYSDATE,'BLACKFRIDAY','resources/storage/p_14_20SS_New%20Collarless%20Blazer%20%5Bwool%20blend%5D%20%5BBLACK%5D.jpg','','');
