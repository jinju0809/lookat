-- DROP TABLE NOTICE CASCADE CONSTRAINTS;

-- SELECT * FROM NOTICE;

DROP SEQUENCE NOTICE_SEQ;
CREATE SEQUENCE NOTICE_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999
NOCYCLE
NOCACHE;

DROP TABLE NOTICE CASCADE CONSTRAINTS;
CREATE TABLE NOTICE(
	N_NO NUMBER PRIMARY KEY,							-- 공지 번호
	N_TITLE VARCHAR2(100) NOT NULL,						-- 공지 제목
	N_M_NO NUMBER,										-- 회원 번호
	N_CONTENT CLOB,										-- 공지 내용
	N_DATE DATE,										-- 공지 작성일
	N_HIT NUMBER,										-- 공지 조회수
	N_FILENAME VARCHAR2(4000),							-- 공지 첨부파일
	FOREIGN KEY (N_M_NO) REFERENCES MEMBERS (M_NO) ON DELETE CASCADE	
);

-- INSERT --
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'반품 및 교환 안내',1,'
<strong>&nbsp;&nbsp; [상품 배송 안내]</strong>
<ul>
	<li>모든 상품은 CJ대한통운으로 배송됩니다.</li>
	<li>오후 4시 이전 주문 시 당일 발송을 원칙으로 하고 있으나 지역에 따라 추가 배송 소요일이 발생될 수 있습니다.</li>
	<li>도서 산간 지역은 별도의 배송비와 반품비가 추가될 수 있습니다.</li>
</ul>
<p>
	<br/>
</p>
<strong>&nbsp;&nbsp; [교환/반품 안내]</strong>
<ul>
	<li>교환/반품은 배송완료일로부터 7일이내에 상품이 회수되어야 가능합니다.</li>
	<li>상품 불량, 오배송의 경우 택배비 무료로 교환/반품이 가능합니다.</li>
	<li>사이즈교환, 색상교환 등 단순 변심에 의한 교환/반품은 고객부담으로 왕복택배비가 발생합니다.</li>
	<li>교환비의 경우 최초배송비(3,000원) + 교환배송비(3,000원)로 총 6,000원 적용 됩니다.</li>
	<li>반품비의 경우 최초배송비(3,000원) + 반품배송비(3,000원)로 총 6,000원 적용 됩니다.</li>
	<li>반품 시 교환/반품비를 동봉하지 않은 채 상품을 보내주신 경우 환불 금액에서 차감 됩니다.</li>
	<li>반품 시 수트케이스, 더스트백을 누락하여 보내 주신 경우 환불 금액에서 차감될 수 있습니다.</li>
	<li>CJ대한통운이 아닌 타택배를 이용하여 택배비를 착불로 보내신 경우 더 많은 금액이 차감될 수 있습니다.</li>
	<li>
		공정 과정, 원단에 따라 특유의 섬유 냄새가 날 수 있습니다.<br/>
		<span>&nbsp;&nbsp; ※</span>
		새 상품의 경우 원섬유의 공정 과정에 의한 고유의 냄새이므로 하자 사유가 될 수 없는 점 양해 부탁 드립니다.
	</li>
	<li>고객 부주의로 상품이 훼손, 변경된 경우 반품/교환이 불가능합니다.</li>
</ul>
<p>
	<br>
</p>
<strong>&nbsp;&nbsp; [교환/반품이 불가한 경우]</strong>
<ul>
	<li>배송 완료 후 3일 이내에 공식홈페이지에 교환/반품 접수하지 않은 채 상품을 보낸 경우<br/>
		<span>&nbsp;&nbsp; ※</span>
		게시물에 반품의사를 밝히셨더라도 공식홈페이지에 교환/반품 접수를 하셔야 합니다.
	</li>
	<li>배송 완료 후 7일 이내에 상품이 도착하지 않은 경우</li>
	<li>
		고객의 부주의로 상품에 변형이 있거나 훼손된 경우<br/>
		&nbsp;&nbsp; (ex : 상품 TAG 제거, 향수 냄새, 음식물 냄새, 화장품 냄새, 제품수선 등)
	</li>
</ul>
<p>
	<br/>
</p>
<strong>&nbsp;&nbsp; [교환/반품 신청 절차 안내]</strong>
<ul>
	<li>교환/반품을 원하시는 경우 공식홈페이지 내 교환/반품신청을 하신 후 상품을 보내주셔야 합니다.</li>
	<li>공식홈페이지 내 반품신청 후 CJ대한통운 반품예약 페이지를 통해 원송장 번호를 입력하시면 자동수거가 접수 됩니다. <br/>
		<span>&nbsp;&nbsp; ※</span>
		공식홈페이지 내에 교환/반품 접수 하셨더라도 CJ대한통운에 반품예약을 한번 더 하지 않으시면 자동 수거 접수가 되지 않습니다.<br/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 이로 인해 교환/반품 가능일을 넘긴 경우(배송완료일로부터 7일) 교환/반품이 불가합니다.
	</li>
</ul>
<p>
	<br/>
</p>
<strong>&nbsp;&nbsp; [A/S 안내]</strong>
<ul>
	<li>고객센터로 문의 부탁 드립니다.&nbsp;</li>
</ul>
',SYSDATE,0,'');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'LOOKAT 사이즈 교환 배송비 FREE',1,'',SYSDATE,0,'n_01_freesize.jpg');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'대한민국 오피스룩 NO.1 루켓의 모델이 되어주세요',1,'공지사항3입니다.',SYSDATE,0,'n_02_model.jpg');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'2020 여름휴가 공지안내',1,'',SYSDATE,0,'n_03_summer.jpg');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'2020 추석연휴 공지안내',1,'',SYSDATE,0,'n_04_thanksgiving.jpg');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'신용카드 무이자할부 안내',1,'',SYSDATE,0,'n_05_card_notice.jpg');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'2021 LOOKAT 적립금 소멸안내',1,'',SYSDATE,0,'n_06_point.jpg');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'2021 설연휴 배송안내',1,'',SYSDATE,0,'n_07_newyear.jpg');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'검품&배송&CCTV상시녹화 공지',1,'',SYSDATE,0,'n_08_delivery.jpg');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'●무통장입금 계좌번호 변경 안내●',1,'',SYSDATE,0,'n_09_account.jpg');
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,'포토후기쓰고 리뷰퀸 되자!',1,'',SYSDATE,0,'n_10_review_queen.jpg');
