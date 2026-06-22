/*1 관리자 */
DROP TABLE manager
	CASCADE CONSTRAINTS;
/*2 회원 */
DROP TABLE client
	CASCADE CONSTRAINTS;
------------------------------------------
/*3 장바구니 */
DROP TABLE shopping_cart
	CASCADE CONSTRAINTS;
------------------------------------------
/*4 상품 */
DROP TABLE product
	CASCADE CONSTRAINTS;
/*5 상품이미지 */
DROP TABLE product_image
	CASCADE CONSTRAINTS;
/*6 카테고리 */
DROP TABLE category
	CASCADE CONSTRAINTS;
------------------------------------------
/*7 주문 */
DROP TABLE "order"
	CASCADE CONSTRAINTS;
/*8 주문상세(물품1개) */
DROP TABLE order_details
	CASCADE CONSTRAINTS;
/*9 결제 */
DROP TABLE PAYMENT
	CASCADE CONSTRAINTS;
------------------------------------------
/*10 선택배송지 */
DROP TABLE select_delivery
	CASCADE CONSTRAINTS;
/*11 배송지 */
DROP TABLE delivery_destination
	CASCADE CONSTRAINTS;
------------------------------------------
/*12 문의 */
DROP TABLE inquiry
	CASCADE CONSTRAINTS;
/*13 문의유형 */
DROP TABLE inquiry_type
	CASCADE CONSTRAINTS;
------------------------------------------
/*14 클레임 */
DROP TABLE claim
	CASCADE CONSTRAINTS;
/*15 클레임이미지 */
DROP TABLE claim_image
	CASCADE CONSTRAINTS;
------------------------------------------
/* 관리자 */
CREATE TABLE manager (
	manager_ID VARCHAR2(30) NOT NULL, /* 관리자아이디 */
	manager_name VARCHAR2(50), /* 관리자명 */
	manager_hash VARCHAR2(255), /* 비밀번호 */
	manager_tel VARCHAR2(20), /* 전화번호 */
	manager_email VARCHAR2(200), /* 이메일 */
	manager_input_date DATE DEFAULT SYSDATE/* 입력일 */
);

CREATE UNIQUE INDEX PK_manager
	ON manager (
		manager_ID ASC
	);

ALTER TABLE manager
	ADD
		CONSTRAINT PK_manager
		PRIMARY KEY (
			manager_ID
		);

/* 회원 */
CREATE TABLE client (
	client_ID VARCHAR2(30) NOT NULL, /* 회원아이디 */
	client_hash VARCHAR2(255), /* 비밀번호 */
	client_name VARCHAR2(50), /* 회원명 */
	client_email VARCHAR2(100), /* 이메일 */
	client_tel VARCHAR2(20), /* 휴대폰 */
	client_birth DATE, /* 생년월일 */
	client_ip VARCHAR2(15), /* IP */
	client_check CHAR(1), /* 마케팅선택체크 */
	client_start_date DATE default to_char(sysdate, 'YYYY-MM-DD'), /* 가입일 */
	client_delete_account CHAR(1) default 'N', /* 탈퇴여부 */
	client_last_date DATE /* 탈퇴일 */
);

CREATE UNIQUE INDEX PK_client
	ON client (
		client_ID ASC
	);

ALTER TABLE client
	ADD
		CONSTRAINT PK_client
		PRIMARY KEY (
			client_ID
		);
------------------------------------------
/* 장바구니 */
CREATE TABLE shopping_cart (
	cart_ID VARCHAR2(30) NOT NULL, /* 장바구니아이디 */
	quantity NUMBER(5), /* 수량 */
	client_ID VARCHAR2(30), /* 회원아이디 */
	product_ID VARCHAR2(500) /* 상품아이디 */
);

CREATE UNIQUE INDEX PK_shopping_cart
	ON shopping_cart (
		cart_ID ASC
	);

ALTER TABLE shopping_cart
	ADD
		CONSTRAINT PK_shopping_cart
		PRIMARY KEY (
			cart_ID
		);
------------------------------------------
/* 상품 */
CREATE TABLE product (
	product_ID VARCHAR2(500) NOT NULL, /* 상품아이디 */
	product_name VARCHAR2(300), /* 상품명 */
	product_type VARCHAR2(50), /* 상품타입 */
	price NUMBER(10), /* 가격 */
	description VARCHAR2(600), /* 설명 */
	discount NUMBER(10), /* 할인 */
	manufacturer VARCHAR2(90), /* 제조사 */
	origin VARCHAR2(90), /* 원산지 */
	underage_purchase CHAR(1), /* 미성년자구매 */
	weight NUMBER(6), /* 중량 */
	expiration_date DATE, /* 유통기한 */
	storage_type VARCHAR2(100), /* 보관유형 */
	min_purchase NUMBER(5), /* 최소구매수량 */
	max_purchase NUMBER(5), /* 최대구매수량 */
	product_input_date DATE DEFAULT SYSDATE, /* 입력일 */
	category_ID VARCHAR2(500) /* 카테고리아이디 */
);

CREATE UNIQUE INDEX PK_product
	ON product (
		product_ID ASC
	);

ALTER TABLE product
	ADD
		CONSTRAINT PK_product
		PRIMARY KEY (
			product_ID
		);

    /* 상품이미지 */
CREATE TABLE product_image (
	product_img_id VARCHAR2(30) NOT NULL, /* 이미지아이디 */
	product_ID VARCHAR2(30), /* 이미지타입 */
	image_type VARCHAR2(20), /* URL */
	URL VARCHAR2(500) /* 상품아이디 */
);

CREATE UNIQUE INDEX PK_product_image
	ON product_image (
		product_img_id ASC
	);

ALTER TABLE product_image
	ADD
		CONSTRAINT PK_product_image
		PRIMARY KEY (
			product_img_id
		);

/* 카테고리 */
CREATE TABLE category (
	category_ID VARCHAR2(500) NOT NULL, /* 카테고리아이디 */
	category_name VARCHAR2(50), /* 카테고리명 */
	isdeleted CHAR(1) default 'N'
);

CREATE UNIQUE INDEX PK_category
	ON category (
		category_ID ASC
	);

ALTER TABLE category
	ADD
		CONSTRAINT PK_category
		PRIMARY KEY (
			category_ID
		);
------------------------------------------
/* 주문 */
CREATE TABLE "order" (
	order_ID VARCHAR2(30) NOT NULL, /* 주문아이디 */
	order_date DATE DEFAULT SYSDATE, /* 주문일자 */
	total_amount NUMBER(12), /* 총금액 */
	order_status VARCHAR2(30), /* 주문상태 */
	delivery_status VARCHAR2(30), /* 배송상태 */
	delivery_request VARCHAR2(500), /* 배송요청사항 */
	delivery_start_date DATE, /* 배송시작일 */
	delivery_completion_date DATE, /* 배송완료일 */
	client_ID VARCHAR2(30) /* 회원아이디 */
);

CREATE UNIQUE INDEX PK_order
	ON "order" (
		order_ID ASC
	);

ALTER TABLE "order"
	ADD
		CONSTRAINT PK_order
		PRIMARY KEY (
			order_ID
		);

/* 주문상세(물품1개) */
CREATE TABLE order_details (
	order_details_ID VARCHAR2(30) NOT NULL, /* 주문상세아이디 */
	quantity NUMBER(5), /* 수량 */
	price NUMBER(10), /* 단가 */
	product_ID VARCHAR2(500), /* 상품아이디 */
	order_ID VARCHAR2(30) /* 주문아이디 */
);

CREATE UNIQUE INDEX PK_order_details
	ON order_details (
		order_details_ID ASC
	);

ALTER TABLE order_details
	ADD
		CONSTRAINT PK_order_details
		PRIMARY KEY (
			order_details_ID
		);

/* 결제 */
CREATE TABLE PAYMENT (
	paymentID VARCHAR2(200) NOT NULL, /* 결제ID */
	order_ID VARCHAR2(30), /* 주문아이디 */
	paymet_type VARCHAR2(50), /* 결제타입 */
	payment_date DATE /* 결제일자 */
);



CREATE UNIQUE INDEX PK_PAYMENT
	ON PAYMENT (
		paymentID ASC
	);

ALTER TABLE PAYMENT
	ADD
		CONSTRAINT PK_PAYMENT
		PRIMARY KEY (
			paymentID
		);
------------------------------------------
/* 선택배송지 */
CREATE TABLE select_delivery (
	delivery_ID VARCHAR2(30), /* 배송아이디 */
	order_ID VARCHAR2(30) /* 주문아이디 */
);

/* 배송지 */
CREATE TABLE delivery_destination (
	delivery_ID VARCHAR2(30) NOT NULL, /* 배송아이디 */
	delivery_postcode VARCHAR2(30), /* 배송우편번호 */
	delivery_addr VARCHAR2(300), /* 배송주소 */
	first_destination CHAR(1), /* 기본배송지FLAG */
	delivery_input_date DATE DEFAULT SYSDATE, /* 입력일 */
	client_ID VARCHAR2(30) /* 회원아이디 */
);

CREATE UNIQUE INDEX PK_delivery_destination
	ON delivery_destination (
		delivery_ID ASC
	);

ALTER TABLE delivery_destination
	ADD
		CONSTRAINT PK_delivery_destination
		PRIMARY KEY (
			delivery_ID
		);
------------------------------------------
/* 문의유형 */
CREATE TABLE inquiry_type (
	inquiry_code VARCHAR2(30) NOT NULL, /* 문의코드 */
	inquiry_name VARCHAR2(200), /* 문의명 */
	inquiry_type VARCHAR2(30) /* 문의유형 */
);

CREATE UNIQUE INDEX PK_inquiry_type
	ON inquiry_type (
		inquiry_code ASC
	);

ALTER TABLE inquiry_type
	ADD
		CONSTRAINT PK_inquiry_type
		PRIMARY KEY (
			inquiry_code
		);

/* 문의 */
CREATE TABLE inquiry (
	inquiry_ID VARCHAR2(30) NOT NULL, /* 문의아이디 */
	inquiry_date DATE DEFAULT SYSDATE, /* 문의일자 */
	inquiry_title VARCHAR2(200), /* 제목 */
	inquiry_secret CHAR(1), /* 비밀글 */
	inquiry_content CLOB, /* 내용 */
	answer_status VARCHAR2(30), /* 답변상태 없어도 */
	answer CLOB, /* 답변 */
	answer_date DATE, /* 답변일자 */
	inquiry_code VARCHAR2(30), /* 문의코드 */
	order_details_ID VARCHAR2(30) /* 주문상세아이디 */
);

CREATE UNIQUE INDEX PK_inquiry
	ON inquiry (
		inquiry_ID ASC
	);

ALTER TABLE inquiry
	ADD
		CONSTRAINT PK_inquiry
		PRIMARY KEY (
			inquiry_ID
		);
------------------------------------------
/* 클레임 */
CREATE TABLE claim (
	claim_ID VARCHAR2(30) NOT NULL, /* 클레임아이디 */
	claim_type VARCHAR2(20), /* 클레임유형 */
	requestdate DATE DEFAULT SYSDATE, /* 요청일 */
	reason VARCHAR2(500), /* 사유 */
	reason_detail CLOB, /* 상세사유 */
	status VARCHAR2(30), /* 상태 */
	processingdate DATE, /* 처리일자 */
	order_details_ID VARCHAR2(30) /* 주문상세아이디 */
);

CREATE UNIQUE INDEX PK_claim
	ON claim (
		claim_ID ASC
	);

ALTER TABLE claim
	ADD
		CONSTRAINT PK_claim
		PRIMARY KEY (
			claim_ID
		);

/* 클레임이미지 */
CREATE TABLE claim_image (
	claim_img_ID VARCHAR2(30) NOT NULL, /* 이미지아이디 */
	claim_ID VARCHAR2(30) NOT NULL, /* 클레임아이디 */
	file_name VARCHAR2(500) /* 파일명 */
);

CREATE UNIQUE INDEX PK_claim_image
	ON claim_image (
		claim_img_ID ASC,
		claim_ID ASC
	);

ALTER TABLE claim_image
	ADD
		CONSTRAINT PK_claim_image
		PRIMARY KEY (
			claim_img_ID,
			claim_ID
		);
------------------------------------------
ALTER TABLE product
	ADD
		CONSTRAINT FK_category_TO_product
		FOREIGN KEY (
			category_ID
		)
		REFERENCES category (
			category_ID
		);

ALTER TABLE "order"
	ADD
		CONSTRAINT FK_client_TO_order
		FOREIGN KEY (
			client_ID
		)
		REFERENCES client (
			client_ID
		);

ALTER TABLE shopping_cart
	ADD
		CONSTRAINT FK_client_TO_shopping_cart
		FOREIGN KEY (
			client_ID
		)
		REFERENCES client (
			client_ID
		);

ALTER TABLE shopping_cart
	ADD
		CONSTRAINT FK_product_TO_shopping_cart
		FOREIGN KEY (
			product_ID
		)
		REFERENCES product (
			product_ID
		);

ALTER TABLE delivery_destination
	ADD
		CONSTRAINT FK_client_TO_delivery_destination
		FOREIGN KEY (
			client_ID
		)
		REFERENCES client (
			client_ID
		);

ALTER TABLE order_details
	ADD
		CONSTRAINT FK_product_TO_order_details
		FOREIGN KEY (
			product_ID
		)
		REFERENCES product (
			product_ID
		);

ALTER TABLE order_details
	ADD
		CONSTRAINT FK_order_TO_order_details
		FOREIGN KEY (
			order_ID
		)
		REFERENCES "order" (
			order_ID
		);

ALTER TABLE inquiry
	ADD
		CONSTRAINT FK_inquiry_type_TO_inquiry
		FOREIGN KEY (
			inquiry_code
		)
		REFERENCES inquiry_type (
			inquiry_code
		);

ALTER TABLE inquiry
	ADD
		CONSTRAINT FK_order_details_TO_inquiry
		FOREIGN KEY (
			order_details_ID
		)
		REFERENCES order_details (
			order_details_ID
		);

ALTER TABLE product_image
	ADD
		CONSTRAINT FK_product_TO_product_image
		FOREIGN KEY (
			URL
		)
		REFERENCES product (
			product_ID
		);

ALTER TABLE claim
	ADD
		CONSTRAINT FK_order_details_TO_claim
		FOREIGN KEY (
			order_details_ID
		)
		REFERENCES order_details (
			order_details_ID
		);

ALTER TABLE claim_image
	ADD
		CONSTRAINT FK_claim_TO_claim_image
		FOREIGN KEY (
			claim_ID
		)
		REFERENCES claim (
			claim_ID
		);

ALTER TABLE select_delivery
	ADD
		CONSTRAINT FK_delivery_destination_TO_select_delivery
		FOREIGN KEY (
			delivery_ID
		)
		REFERENCES delivery_destination (
			delivery_ID
		);

ALTER TABLE select_delivery
	ADD
		CONSTRAINT FK_order_TO_select_delivery
		FOREIGN KEY (
			order_ID
		)
		REFERENCES "order" (
			order_ID
		);

ALTER TABLE PAYMENT
	ADD
		CONSTRAINT FK_order_TO_PAYMENT
		FOREIGN KEY (
			order_ID
		)
		REFERENCES "order" (
			order_ID
		);
--------------------------------------------------------------
/* ===========================
   6. 카테고리
=========================== */
INSERT INTO category (category_ID, category_name)
VALUES ('C001', '과일');

INSERT INTO category (category_ID, category_name)
VALUES ('C002', '채소');

INSERT INTO category (category_ID, category_name)
VALUES ('C003', '음료');
/* ===========================
   4. 상품 (총 6개)
=========================== */
INSERT INTO product (
product_ID, product_name, product_type, price, description,
discount, manufacturer, origin, underage_purchase,
weight, expiration_date, storage_type,
min_purchase, max_purchase, category_ID
)
VALUES (
'P001', '사과', '식품', 3000, '맛있는 사과',
0, '농협', '국산', 'N',
1000, SYSDATE+30, '상온',
1, 10, 'C001'
);

INSERT INTO product (
product_ID, product_name, product_type, price, description,
discount, manufacturer, origin, underage_purchase,
weight, expiration_date, storage_type,
min_purchase, max_purchase, category_ID
)
VALUES (
'P002', '당근', '식품', 2000, '신선한 당근',
10, '농협', '국산', 'N',
500, SYSDATE+20, '냉장',
1, 20, 'C002'
);

INSERT INTO product (
product_ID, product_name, product_type, price, description,
discount, manufacturer, origin, underage_purchase,
weight, expiration_date, storage_type,
min_purchase, max_purchase, category_ID
)
VALUES (
'P003', '콜라', '음료', 2500, '탄산음료',
0, '코카콜라', '한국', 'N',
1500, SYSDATE+365, '상온',
1, 30, 'C003'
);

INSERT INTO product (
product_ID, product_name, product_type, price, description,
discount, manufacturer, origin, underage_purchase,
weight, expiration_date, storage_type,
min_purchase, max_purchase, category_ID
)
VALUES (
'P004', '바나나', '식품', 4000, '달콤한 바나나',
0, '돌', '필리핀', 'N',
1200, SYSDATE+14, '상온',
1, 10, 'C001'
);

INSERT INTO product (
product_ID, product_name, product_type, price, description,
discount, manufacturer, origin, underage_purchase,
weight, expiration_date, storage_type,
min_purchase, max_purchase, category_ID
)
VALUES (
'P005', '양파', '식품', 3500, '국산 양파',
5, '농협', '국산', 'N',
1500, SYSDATE+30, '상온',
1, 20, 'C002'
);

INSERT INTO product (
product_ID, product_name, product_type, price, description,
discount, manufacturer, origin, underage_purchase,
weight, expiration_date, storage_type,
min_purchase, max_purchase, category_ID
)
VALUES (
'P006', '사이다', '음료', 1800, '청량한 탄산음료',
0, '칠성', '한국', 'N',
500, SYSDATE+365, '상온',
1, 30, 'C003'
);
/* ===========================
   5. 상품이미지
=========================== */
INSERT INTO product_image
(product_img_id, product_ID, image_type, URL)
VALUES ('IMG001', 'P001', 'MAIN', 'P001');

INSERT INTO product_image
(product_img_id, product_ID, image_type, URL)
VALUES ('IMG002', 'P002', 'MAIN', 'P002');

INSERT INTO product_image
(product_img_id, product_ID, image_type, URL)
VALUES ('IMG003', 'P003', 'MAIN', 'P003');

INSERT INTO product_image
(product_img_id, product_ID, image_type, URL)
VALUES ('IMG004', 'P004', 'MAIN', 'P004');

INSERT INTO product_image
(product_img_id, product_ID, image_type, URL)
VALUES ('IMG005', 'P005', 'MAIN', 'P005');

INSERT INTO product_image
(product_img_id, product_ID, image_type, URL)
VALUES ('IMG006', 'P006', 'MAIN', 'P006');
/* ===========================
   1. 관리자
=========================== */
INSERT INTO manager
(manager_ID, manager_name, manager_hash, manager_tel, manager_email)
VALUES
('admin01', '김관리', '1234', '010-1111-2222', 'admin01@test.com');

/* ===========================
   2. 회원
=========================== */
INSERT INTO client (
client_ID, client_hash, client_name, client_email,
client_tel, client_birth, client_ip,
client_check,
client_last_date
)
VALUES (
'user01', '1234', '홍길동', 'hong@test.com',
'01011111111', DATE '2000-01-01', '1.1.1.1',
'Y',  NULL
);

INSERT INTO client (
client_ID, client_hash, client_name, client_email,
client_tel, client_birth, client_ip,
client_check,
client_last_date
)
VALUES (
'user02', '1234', '김철수', 'kim@test.com',
'01022222222', DATE '1999-02-02', '2.2.2.2',
'N',  NULL
);

INSERT INTO client (
client_ID, client_hash, client_name, client_email,
client_tel, client_birth, client_ip,
client_check,
client_last_date
)
VALUES (
'user03', '1234', '이영희', 'lee@test.com',
'01033333333', DATE '2001-03-03', '3.3.3.3',
'Y',  NULL
);


/* ===========================
   3. 장바구니
=========================== */
INSERT INTO shopping_cart
(cart_ID, quantity, client_ID, product_ID)
VALUES ('SC001', 2, 'user01', 'P001');

INSERT INTO shopping_cart
(cart_ID, quantity, client_ID, product_ID)
VALUES ('SC002', 1, 'user02', 'P002');

INSERT INTO shopping_cart
(cart_ID, quantity, client_ID, product_ID)
VALUES ('SC003', 3, 'user03', 'P003');


/* ===========================
   주문
=========================== */
insert into "order"(ORDER_ID, TOTAL_AMOUNT, ORDER_STATUS, DELIVERY_STATUS, DELIVERY_REQUEST, DELIVERY_START_DATE, delivery_completion_date, CLIENT_ID) values(
'order0001', 1, '일반배송', '배송완료', '배송요청사항없음', '2026-06-06','2026-06-08', 'user01'
);

insert into "order"(ORDER_ID, TOTAL_AMOUNT, ORDER_STATUS, DELIVERY_STATUS, DELIVERY_REQUEST, DELIVERY_START_DATE, CLIENT_ID) values(
'order0002', 3, '일반배송', '배송중', '배송요청사항없음', '2026-06-08', 'user02'
);


insert into "order"(ORDER_ID, TOTAL_AMOUNT, ORDER_STATUS, DELIVERY_STATUS, DELIVERY_REQUEST, DELIVERY_START_DATE, CLIENT_ID) values(
'order0003', 2, '일반배송', '배송대기', '배송요청사항없음', '2026-06-10', 'user03'
);
/* ===========================
   주문상세
=========================== */
insert into order_details(order_details_id, quantity, price, product_id, order_id) values
('od001', 1, 25000, 'P001', 'order0001');

insert into order_details(order_details_id, quantity, price, product_id, order_id) values
('od002', 1, 12000, 'P002', 'order0002');

insert into order_details(order_details_id, quantity, price, product_id, order_id) values
('od003', 1, 33000, 'P003', 'order0002');

insert into order_details(order_details_id, quantity, price, product_id, order_id) values
('od004', 1, 2000, 'P004', 'order0002');

insert into order_details(order_details_id, quantity, price, product_id, order_id) values
('od005', 1, 16000, 'P005', 'order0003');

insert into order_details(order_details_id, quantity, price, product_id, order_id) values
('od006', 1, 64000, 'P006', 'order0003');
/* ===========================
   결제
=========================== */
insert into payment values('pmt001', 'order0001','일반결제','2026-06-06');
insert into payment values('pmt002', 'order0002','자동결제','2026-06-08');
insert into payment values('pmt003', 'order0003','브랜드페이','2026-06-10');
/* ===========================
   배송지
=========================== */
insert into delivery_destination( DELIVERY_ID, DELIVERY_POSTCODE, DELIVERY_ADDR, FIRST_DESTINATION, CLIENT_ID) values(
'dlvy001', '05800', '서울시 송파구 문정동', 'T', 'user01');
);
insert into delivery_destination( DELIVERY_ID, DELIVERY_POSTCODE, DELIVERY_ADDR, FIRST_DESTINATION, CLIENT_ID) values(
'dlvy002', '05820', '서울시 송파구 장지동', 'F', 'user01');
);
/* ===========================
   선택배송지
=========================== */
insert into select_delivery values( 'dlvy001','order0001' );
insert into select_delivery values( 'dlvy001','order0002' );
insert into select_delivery values( 'dlvy002','order0003' );
/* ===========================
   문의유형
=========================== */
insert into INQUIRY_TYPE values('c1','inquery_name인데 뭐였죠?','1대1 문의');
insert into INQUIRY_TYPE values('c2','inquery_name인데 뭐였죠?','상품 문의');
/* ===========================
   문의
=========================== */
insert into INQUIRY(INQUIRY_ID, INQUIRY_TITLE, INQUIRY_SECRET, INQUIRY_CONTENT, ANSWER_STATUS, ANSWER, ANSWER_DATE, INQUIRY_CODE, ORDER_DETAILS_ID)values(
'iq001','문의입니다', 'T', '내용', '답변완료','답변내용', sysdate, 'c1', 'od003');
insert into INQUIRY(INQUIRY_ID, INQUIRY_TITLE, INQUIRY_SECRET, INQUIRY_CONTENT, ANSWER_STATUS, INQUIRY_CODE, ORDER_DETAILS_ID)values(
'iq002','문의', 'F', '내용', '대기중', 'c2', 'od003');
insert into INQUIRY(INQUIRY_ID, INQUIRY_TITLE, INQUIRY_SECRET, INQUIRY_CONTENT, ANSWER_STATUS, INQUIRY_CODE, ORDER_DETAILS_ID)values(
'iq003','문의니다', 'T', '내용', '대기중','c2', 'od003');
/* ===========================
   14. 클레임
=========================== */

INSERT INTO claim
(claim_ID, claim_type, requestdate, reason,
reason_detail, status, processingdate, order_details_ID)
VALUES
('CL001', '환불', SYSDATE-5, '상품 파손',
'배송 중 상품이 파손되어 환불 요청',
'처리완료', SYSDATE-3, 'od001');

INSERT INTO claim
(claim_ID, claim_type, requestdate, reason,
reason_detail, status, processingdate, order_details_ID)
VALUES
('CL002', '교환', SYSDATE-2, '오배송',
'주문한 상품과 다른 상품이 배송됨',
'처리중', NULL, 'od003');

INSERT INTO claim
(claim_ID, claim_type, requestdate, reason,
reason_detail, status, processingdate, order_details_ID)
VALUES
('CL003', '반품', SYSDATE-1, '단순변심',
'생각했던 상품과 달라 반품 요청',
'접수완료', NULL, 'od005');
/* ===========================
   15. 클레임이미지
=========================== */

INSERT INTO claim_image
(claim_img_ID, claim_ID, file_name)
VALUES
('CIMG001', 'CL001', 'damage1.jpg');

INSERT INTO claim_image
(claim_img_ID, claim_ID, file_name)
VALUES
('CIMG002', 'CL002', 'wrong_item.jpg');

INSERT INTO claim_image
(claim_img_ID, claim_ID, file_name)
VALUES
('CIMG003', 'CL003', 'return_request.jpg');

COMMIT;
