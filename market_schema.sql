/*1 관리자 */
DROP TABLE manager
	CASCADE CONSTRAINTS;
/*2 회원 */
DROP TRIGGER trg_client_no;
DROP TABLE client
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_client_no;
------------------------------------------
/*3 장바구니 */
DROP TRIGGER trg_cart_id;
DROP TABLE shopping_cart
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_cart_id;
------------------------------------------
/*4 상품 */
DROP TRIGGER trg_product_id;
DROP TABLE product
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_product_id;
/*5 상품이미지 */
DROP TRIGGER trg_product_img_id;
DROP TABLE product_image
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_product_img_id;
/*6 카테고리 */
DROP TRIGGER trg_category_id;
DROP TABLE category
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_category_id;
/*7 상품 옵션 */
DROP TRIGGER trg_option_id;
DROP TABLE product_option
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_option_id;
/*8 추가정보 */
DROP TRIGGER trg_additional_id;
DROP TABLE additional_info
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_additional_id;
------------------------------------------
/*9 주문 */
DROP TRIGGER trg_order_id;
DROP TABLE orders
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_order_id;
/*10 주문상세(물품1개) */
DROP TRIGGER trg_order_details_id;
DROP TABLE order_details
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_order_details_id;
/*11 결제 */
DROP TRIGGER trg_payment_id;
DROP TABLE PAYMENT
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_payment_id;
------------------------------------------
/*12 선택배송지 */
DROP TRIGGER trg_delivery_id;
DROP TABLE select_delivery
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_delivery_id;
/*13 배송지 */
DROP TABLE delivery_destination
	CASCADE CONSTRAINTS;
------------------------------------------
/*14 문의 */
DROP TRIGGER trg_inquiry_id;
DROP TABLE inquiry
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_inquiry_id;
/*15 문의유형 */
DROP TRIGGER trg_inquiry_type_id;
DROP TABLE inquiry_type
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_inquiry_type_id;
------------------------------------------
/*16 클레임 */
DROP TRIGGER trg_claim_id;
DROP TABLE claim
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_claim_id;
/*17 클레임이미지 */
DROP TRIGGER trg_claim_img_id;
DROP TABLE claim_image
	CASCADE CONSTRAINTS;
DROP SEQUENCE seq_claim_img_id;
------------------------------------------
/*1 관리자 */

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

/*2 회원 */

CREATE TABLE client (
	client_No VARCHAR2(30) NOT NULL, /* 회원 번호 */
	client_ID VARCHAR2(30), /* 회원아이디 */
	client_hash VARCHAR2(255), /* 비밀번호 */
	client_name VARCHAR2(50), /* 회원명 */
	client_email VARCHAR2(100), /* 이메일 */
	client_tel VARCHAR2(20), /* 휴대폰 */
	client_birth DATE, /* 생년월일 */
	client_ip VARCHAR2(15), /* IP */
	client_check CHAR(1), /* 마케팅선택체크 */
	client_start_date DATE default sysdate, /* 가입일 */
	client_delete_account CHAR(1) default 'N', /* 탈퇴여부 */
	client_last_date DATE DEFAULT NULL/* 탈퇴일 */
);

CREATE UNIQUE INDEX PK_client
	ON client (
		client_No ASC
	);

ALTER TABLE client
	ADD
		CONSTRAINT PK_client
		PRIMARY KEY (
			client_No
		);
CREATE SEQUENCE seq_client_no
START WITH 1
INCREMENT BY 1
MAXVALUE 999999
NOCYCLE
NOCACHE;

CREATE OR REPLACE TRIGGER trg_client_no
BEFORE INSERT ON client
FOR EACH ROW
BEGIN
  IF :NEW.client_No IS NULL THEN
    :NEW.client_No := 'C' || LPAD(seq_client_no.NEXTVAL, 6, '0');
  END IF;
END;
/
------------------------------------------
/*3 장바구니 */

CREATE TABLE shopping_cart (
	cart_ID VARCHAR2(30) NOT NULL, /* 장바구니아이디 */
	quantity NUMBER(5), /* 수량 */
	input_date date default sysdate, /* 추가일 */
	client_No VARCHAR2(30), /* 회원아이디 */
	option_ID VARCHAR2(100) /* 상품아이디 */
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
CREATE SEQUENCE seq_cart_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_cart_id
BEFORE INSERT ON shopping_cart FOR EACH ROW
BEGIN
  IF :NEW.cart_ID IS NULL THEN
    :NEW.cart_ID := 'CRT' || LPAD(seq_cart_id.NEXTVAL, 6, '0');
  END IF;
END;
/
------------------------------------------
/*4 상품 */

CREATE TABLE product (
	product_ID VARCHAR2(500) NOT NULL, /* 상품아이디 */
	product_name VARCHAR2(300), /* 상품명 */
	product_type VARCHAR2(50), /* 상품타입 */
	price NUMBER(10), /* 가격 */
	notice CLOB, /* 안내사항 */
	shortinfo VARCHAR2(60), 	/* 짧은 설명  */
	description VARCHAR2(600), /* 설명 */
	discount NUMBER(10), /* 할인 */
	manufacturer VARCHAR2(90), /* 제조사 */
	origin VARCHAR2(90), /* 원산지 */
	underage_purchase CHAR(1), /* 미성년자구매 */
	weight NUMBER(6), /* 중량 */
	expiration_date DATE, /* 유통기한 */
	storage_type VARCHAR2(100), /* 보관유형 */
	unit VARCHAR2(100),	/* 판매단위 */
	min_purchase NUMBER(5), /* 최소구매수량 */
	max_purchase NUMBER(5), /* 최대구매수량 */
	product_input_date DATE DEFAULT sysdate, /* 입력일 */
	is_deleted CHAR(1) default 'N', /* 삭제상태 */
	category_ID VARCHAR2(500) /* 카테고리아이디 */
);
CREATE SEQUENCE seq_product_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_product_id
BEFORE INSERT ON product FOR EACH ROW
BEGIN
  IF :NEW.product_ID IS NULL THEN
    :NEW.product_ID := 'P' || LPAD(seq_product_id.NEXTVAL, 6, '0');
  END IF;
END;
/
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

/*5 상품이미지 */

CREATE TABLE product_image (
	product_img_id VARCHAR2(30) NOT NULL, /* 이미지아이디 */
	URL VARCHAR2(100),    /* URL */
	image_type VARCHAR2(50), /* 이미지종류 */
	product_ID VARCHAR2(500) /* 상품아이디 */
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
CREATE SEQUENCE seq_product_img_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_product_img_id
BEFORE INSERT ON product_image FOR EACH ROW
BEGIN
  IF :NEW.product_img_id IS NULL THEN
    :NEW.product_img_id := 'IMG' || LPAD(seq_product_img_id.NEXTVAL, 6, '0');
  END IF;
END;
/
/*6 카테고리 */

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
CREATE SEQUENCE seq_category_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_category_id
BEFORE INSERT ON category FOR EACH ROW
BEGIN
  IF :NEW.category_ID IS NULL THEN
    :NEW.category_ID := 'CAT' || LPAD(seq_category_id.NEXTVAL, 6, '0');
  END IF;
END;
/
/*7 상품 옵션 */

CREATE TABLE product_option(
	option_id VARCHAR2(100) NOT NULL, /* 상품 옵션 아이디 */
	option_name VARCHAR2(300), /* 옵션명　*/
	extra_charge NUMBER(10), /*　추가금　*/
	stockQuantity NUMBER(10), /* 재고　*/
	product_id VARCHAR2(500) /* 상품아이디　*/
);

CREATE UNIQUE INDEX PK_product_option
	ON product_option (
		option_id ASC
	);

ALTER TABLE product_option
	ADD
		CONSTRAINT PK_product_option
		PRIMARY KEY (
			option_id
		);
CREATE SEQUENCE seq_option_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_option_id
BEFORE INSERT ON product_option FOR EACH ROW
BEGIN
  IF :NEW.option_id IS NULL THEN
    :NEW.option_id := 'OPT' || LPAD(seq_option_id.NEXTVAL, 6, '0');
  END IF;
END;
/
/*8 추가정보 */

CREATE TABLE additional_info(
	additional_id VARCHAR2(30) NOT NULL,
	info_content CLOB,
	product_id VARCHAR2(500)
);

CREATE UNIQUE INDEX PK_additional_info
	ON additional_info (
		additional_id ASC
	);

ALTER TABLE additional_info
	ADD
		CONSTRAINT PK_additional_info
		PRIMARY KEY (
			additional_id
		);
CREATE SEQUENCE seq_additional_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_additional_id
BEFORE INSERT ON additional_info FOR EACH ROW
BEGIN
  IF :NEW.additional_id IS NULL THEN
    :NEW.additional_id := 'ADD' || LPAD(seq_additional_id.NEXTVAL, 6, '0');
  END IF;
END;
/
------------------------------------------
/*9 주문 */

CREATE TABLE orders (
	order_ID VARCHAR2(30) NOT NULL, /* 주문아이디 */
	order_date DATE  default sysdate, /* 주문일자 */
	total_amount NUMBER(12), /* 총금액 */
	order_status VARCHAR2(30), /* 주문상태 */
	delivery_status VARCHAR2(30), /* 배송상태 */
	delivery_request VARCHAR2(500), /* 배송요청사항 */
	delivery_start_date DATE, /* 배송시작일 */
	delivery_completion_date DATE, /* 배송완료일 */
	client_No VARCHAR2(30) /* 회원아이디 */
);

CREATE UNIQUE INDEX PK_orders
	ON orders (
		order_ID ASC
	);

ALTER TABLE orders
	ADD
		CONSTRAINT PK_orders
		PRIMARY KEY (
			order_ID
		);
CREATE SEQUENCE seq_order_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_order_id
BEFORE INSERT ON orders FOR EACH ROW
BEGIN
  IF :NEW.order_ID IS NULL THEN
    :NEW.order_ID := 'O' || LPAD(seq_order_id.NEXTVAL, 6, '0');
  END IF;
END;
/
/*10 주문상세(물품1개) */

CREATE TABLE order_details (
	order_details_ID VARCHAR2(30) NOT NULL, /* 주문상세아이디 */
	quantity NUMBER(5), /* 수량 */
	price NUMBER(10), /* 단가 */
	option_ID VARCHAR2(100), /* 상품옵션아이디 */
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
CREATE SEQUENCE seq_order_details_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_order_details_id
BEFORE INSERT ON order_details FOR EACH ROW
BEGIN
  IF :NEW.order_details_ID IS NULL THEN
    :NEW.order_details_ID := 'OD' || LPAD(seq_order_details_id.NEXTVAL, 6, '0');
  END IF;
END;
/
/*11 결제 */

CREATE TABLE PAYMENT (
	paymentID VARCHAR2(200) NOT NULL, /* 결제ID */
	order_ID VARCHAR2(30), /* 주문아이디 */
	payment_type VARCHAR2(50), /* 결제타입 */
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
CREATE SEQUENCE seq_payment_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_payment_id
BEFORE INSERT ON PAYMENT FOR EACH ROW
BEGIN
  IF :NEW.paymentID IS NULL THEN
    :NEW.paymentID := 'PAY' || LPAD(seq_payment_id.NEXTVAL, 6, '0');
  END IF;
END;
/
------------------------------------------
/*12 선택배송지 */
CREATE TABLE select_delivery (
	delivery_ID VARCHAR2(30), /* 배송아이디 */
	order_ID VARCHAR2(30) /* 주문아이디 */
);

/*13 배송지 */

CREATE TABLE delivery_destination (
	delivery_ID VARCHAR2(30) NOT NULL, /* 배송아이디 */
	delivery_postcode VARCHAR2(30), /* 배송우편번호 */
	delivery_addr VARCHAR2(300), /* 배송주소 */
	first_destination CHAR(1), /* 기본배송지FLAG */
	delivery_input_date DATE  default sysdate, /* 입력일 */
	client_No VARCHAR2(30) /* 회원아이디 */
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
CREATE SEQUENCE seq_delivery_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_delivery_id
BEFORE INSERT ON delivery_destination FOR EACH ROW
BEGIN
  IF :NEW.delivery_ID IS NULL THEN
    :NEW.delivery_ID := 'DLV' || LPAD(seq_delivery_id.NEXTVAL, 6, '0');
  END IF;
END;
/
------------------------------------------
/*14 문의 */

CREATE TABLE inquiry (
	inquiry_ID VARCHAR2(30) NOT NULL, /* 문의아이디 */
	inquiry_date DATE  default sysdate, /* 문의일자 */
	inquiry_title VARCHAR2(200), /* 제목 */
	inquiry_secret CHAR(1), /* 비밀글 */
	inquiry_content CLOB, /* 내용 */
	answer_status VARCHAR2(30), /* 답변상태 없어도 */
	answer CLOB, /* 답변 */
	answer_date DATE, /* 답변일자 */
	inquiry_status CHAR(1) default 'N',	/* 삭제상태 */
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
CREATE SEQUENCE seq_inquiry_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_inquiry_id
BEFORE INSERT ON inquiry FOR EACH ROW
BEGIN
  IF :NEW.inquiry_ID IS NULL THEN
    :NEW.inquiry_ID := 'INQ' || LPAD(seq_inquiry_id.NEXTVAL, 6, '0');
  END IF;
END;
/
/*15 문의유형 */
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
CREATE SEQUENCE seq_inquiry_type_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_inquiry_type_id
BEFORE INSERT ON inquiry_type FOR EACH ROW
BEGIN
  IF :NEW.inquiry_code IS NULL THEN
    :NEW.inquiry_code := 'TYP' || LPAD(seq_inquiry_type_id.NEXTVAL, 6, '0');
  END IF;
END;
/
------------------------------------------
/*16 클레임 */
CREATE TABLE claim (
	claim_ID VARCHAR2(30) NOT NULL, /* 클레임아이디 */
	claim_type VARCHAR2(20), /* 클레임유형 */
	requestdate DATE default sysdate, /* 요청일 */
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
CREATE SEQUENCE seq_claim_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_claim_id
BEFORE INSERT ON claim FOR EACH ROW
BEGIN
  IF :NEW.claim_ID IS NULL THEN
    :NEW.claim_ID := 'CLM' || LPAD(seq_claim_id.NEXTVAL, 6, '0');
  END IF;
END;
/
/*17 클레임이미지 */

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
CREATE SEQUENCE seq_claim_img_id START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCYCLE NOCACHE;

CREATE OR REPLACE TRIGGER trg_claim_img_id
BEFORE INSERT ON claim_image FOR EACH ROW
BEGIN
  IF :NEW.claim_img_ID IS NULL THEN
    :NEW.claim_img_ID := 'CIMG' || LPAD(seq_claim_img_id.NEXTVAL, 6, '0');
  END IF;
END;
/
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

ALTER TABLE product_option
	ADD
		CONSTRAINT FK_product_TO_product_option
		FOREIGN KEY (
			product_ID
		)
		REFERENCES product (
			product_ID
		);

ALTER TABLE additional_info
	ADD
		CONSTRAINT FK_product_TO_additional_info
			FOREIGN KEY (
			product_ID
		)
		REFERENCES product (
			product_ID
		);

ALTER TABLE orders
	ADD
		CONSTRAINT FK_client_TO_order
		FOREIGN KEY (
			client_No
		)
		REFERENCES client (
			client_No
		);

ALTER TABLE shopping_cart
	ADD
		CONSTRAINT FK_client_TO_shopping_cart
		FOREIGN KEY (
			client_No
		)
		REFERENCES client (
			client_No
		);

ALTER TABLE shopping_cart
	ADD
		CONSTRAINT FK_product_option_TO_shopping_cart
		FOREIGN KEY (
			option_ID
		)
		REFERENCES product_option (
			option_id
		);

ALTER TABLE delivery_destination
	ADD
		CONSTRAINT FK_client_TO_delivery_destination
		FOREIGN KEY (
			client_No
		)
		REFERENCES client (
			client_No
		);

ALTER TABLE order_details
	ADD
		CONSTRAINT FK_product_option_TO_order_details
		FOREIGN KEY (
			option_ID
		)
		REFERENCES product_option (
			option_id
		);

ALTER TABLE order_details
	ADD
		CONSTRAINT FK_order_TO_order_details
		FOREIGN KEY (
			order_ID
		)
		REFERENCES orders (
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
			product_ID
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
		REFERENCES orders (
			order_ID
		);

ALTER TABLE PAYMENT
	ADD
		CONSTRAINT FK_order_TO_PAYMENT
		FOREIGN KEY (
			order_ID
		)
		REFERENCES orders (
			order_ID
		);
--------------------------------------------------------------
/* ===========================
   1. 관리자 (manager_ID 자동생성)
=========================== */
INSERT INTO manager (manager_id, manager_name, manager_hash, manager_tel, manager_email)
VALUES ('admin01','김관리', '1234', '010-1234-5541', 'admin01@test.com');


/* ===========================
   2. 회원 (client_No 자동생성: C0001, C0002, C0003...)
=========================== */
INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check)
VALUES ('user01', '1234', '홍길동', 'hong@test.com', '01011111111', DATE '2000-01-01', '1.1.1.1', 'Y');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check)
VALUES ('user02', '1234', '김철수', 'kim@test.com', '01022222222', DATE '1999-02-02', '2.2.2.2', 'N');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check)
VALUES ('user03', '1234', '이영희', 'lee@test.com', '01033333333', DATE '2001-03-03', '3.3.3.3', 'Y');


INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user04', '1234', '박민수', 'park04@test.com', '010-1111-0004', DATE '2001-03-10', '1.1.1.4', 'Y', DATE '2026-01-12');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user05', '1234', '최유리', 'choi05@test.com', '010-1111-0005', DATE '1997-11-30', '1.1.1.5', 'Y', DATE '2026-01-28');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user06', '1234', '정다은', 'jung06@test.com', '010-1111-0006', DATE '1996-06-15', '1.1.1.6', 'Y', DATE '2026-02-02');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user07', '1234', '강지훈', 'kang07@test.com', '010-1111-0007', DATE '2002-02-18', '1.1.1.7', 'Y', DATE '2026-02-10');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user08', '1234', '윤수빈', 'yoon08@test.com', '010-1111-0008', DATE '1995-09-08', '1.1.1.8', 'Y', DATE '2026-02-17');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user09', '1234', '한지민', 'han09@test.com', '010-1111-0009', DATE '1994-04-01', '1.1.1.9', 'Y', DATE '2026-02-26');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user10', '1234', '오세훈', 'oh10@test.com', '010-1111-0010', DATE '1993-12-25', '1.1.1.10', 'Y', DATE '2026-03-01');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user11', '1234', '신예은', 'shin11@test.com', '010-1111-0011', DATE '2000-10-19', '1.1.1.11', 'Y', DATE '2026-03-07');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user12', '1234', '조현우', 'jo12@test.com', '010-1111-0012', DATE '1992-01-21', '1.1.1.12', 'Y', DATE '2026-03-14');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user13', '1234', '백지훈', 'baek13@test.com', '010-1111-0013', DATE '1999-07-03', '1.1.1.13', 'Y', DATE '2026-03-22');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user14', '1234', '서지은', 'seo14@test.com', '010-1111-0014', DATE '1998-02-13', '1.1.1.14', 'Y', DATE '2026-03-30');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user15', '1234', '문가영', 'moon15@test.com', '010-1111-0015', DATE '2001-11-07', '1.1.1.15', 'Y', DATE '2026-04-02');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user16', '1234', '임현수', 'lim16@test.com', '010-1111-0016', DATE '1995-05-28', '1.1.1.16', 'Y', DATE '2026-04-09');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user17', '1234', '유민재', 'yu17@test.com', '010-1111-0017', DATE '1996-03-16', '1.1.1.17', 'Y', DATE '2026-04-15');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user18', '1234', '송하늘', 'song18@test.com', '010-1111-0018', DATE '1997-12-11', '1.1.1.18', 'Y', DATE '2026-04-23');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user19', '1234', '남도윤', 'nam19@test.com', '010-1111-0019', DATE '1994-09-09', '1.1.1.19', 'Y', DATE '2026-04-29');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user20', '1234', '황예린', 'hwang20@test.com', '010-1111-0020', DATE '2002-07-27', '1.1.1.20', 'Y', DATE '2026-05-03');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user21', '1234', '장우진', 'jang21@test.com', '010-1111-0021', DATE '1998-10-15', '1.1.1.21', 'Y', DATE '2026-05-08');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user22', '1234', '권수아', 'kwon22@test.com', '010-1111-0022', DATE '1997-01-17', '1.1.1.22', 'Y', DATE '2026-05-14');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user23', '1234', '노태윤', 'noh23@test.com', '010-1111-0023', DATE '1996-08-29', '1.1.1.23', 'Y', DATE '2026-05-19');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user24', '1234', '안지수', 'ahn24@test.com', '010-1111-0024', DATE '1995-02-06', '1.1.1.24', 'Y', DATE '2026-05-24');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user25', '1234', '고민재', 'go25@test.com', '010-1111-0025', DATE '1999-06-11', '1.1.1.25', 'Y', DATE '2026-05-30');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user26', '1234', '배수현', 'bae26@test.com', '010-1111-0026', DATE '2000-04-05', '1.1.1.26', 'Y', DATE '2026-06-02');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user27', '1234', '양지훈', 'yang27@test.com', '010-1111-0027', DATE '1998-12-18', '1.1.1.27', 'Y', DATE '2026-06-09');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user28', '1234', '손다은', 'son28@test.com', '010-1111-0028', DATE '1997-09-21', '1.1.1.28', 'Y', DATE '2026-06-18');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date)
VALUES('user29', '1234', '전하린', 'jeon29@test.com', '010-1111-0029', DATE '1996-01-08', '1.1.1.29', 'Y', DATE '2026-06-26');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date, CLIENT_DELETE_ACCOUNT, client_last_date)
VALUES ('user30', '1234', '홍길동', 'hong01@test.com', '010-1111-0001', DATE '2000-01-01', '1.1.1.1', 'Y', DATE '2025-12-03','Y', DATE '2026-01-03');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date, CLIENT_DELETE_ACCOUNT, client_last_date)
VALUES('user31', '1234', '김철수', 'kim02@test.com', '010-1111-0002', DATE '1999-05-12', '1.1.1.2', 'Y', DATE '2025-12-15','Y', DATE '2026-04-04');

INSERT INTO client (client_ID, client_hash, client_name, client_email, client_tel, client_birth, client_ip, client_check, client_start_date, CLIENT_DELETE_ACCOUNT, client_last_date)
VALUES('user32', '1234', '이영희', 'lee03@test.com', '010-1111-0003', DATE '1998-08-20', '1.1.1.3', 'Y', DATE '2026-01-05','Y', DATE '2026-05-21');

/* ===========================
   6. 카테고리 (category_ID 자동생성: CAT000001, CAT000002...)
=========================== */
-- 주의: 상품 등록 시 카테고리 ID가 필요하므로 순서를 상품보다 앞으로 당겼습니다.
INSERT INTO category (category_name) VALUES ('과일'); -- CAT000001
INSERT INTO category (category_name) VALUES ('채소'); -- CAT000002
INSERT INTO category (category_name) VALUES ('음료'); -- CAT000003


/* ===========================
   4. 상품 (product_ID 자동생성: P000001 ~ P000006)
=========================== */
INSERT INTO product (product_name, product_type, price, notice, description,shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type,UNIT, min_purchase, max_purchase, category_ID)
VALUES ('사과', '식품', 3000,'초당옥수수 특성상 ~~~~~ 지않을 수 있지만 정상범주내의 정상상품입니다.', '맛있는 사과', '간단한 설명' ,0, '농협', '국산', 'N', 1000, SYSDATE+30, '상온', '1망', 1, 10, 'CAT000001');

INSERT INTO product (product_name, product_type, price, description,shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, min_purchase, max_purchase, category_ID)
VALUES ('당근', '식품', 2000, '신선한 당근', '간단한 설명', 10, '농협', '국산', 'N', 500, SYSDATE+20, '냉장', 1, 20, 'CAT000002');

INSERT INTO product (product_name, product_type, price, description,shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, min_purchase, max_purchase, category_ID)
VALUES ('콜라', '음료', 2500, '탄산음료', '간단한 설명', 0, '코카콜라', '한국', 'N', 1500, SYSDATE+365, '상온', 1, 30, 'CAT000003');

INSERT INTO product (product_name, product_type, price, description,shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, min_purchase, max_purchase, category_ID)
VALUES ('바나나', '식품', 4000, '달콤한 바나나', '간단한 설명', 0, '돌', '필리핀', 'N', 1200, SYSDATE+14, '상온', 1, 10, 'CAT000001');

INSERT INTO product (product_name, product_type, price, description,shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, min_purchase, max_purchase, category_ID)
VALUES ('양파', '식품', 3500, '국산 양파', '간단한 설명', 5, '농협', '국산', 'N', 1500, SYSDATE+30, '상온', 1, 20, 'CAT000002');

INSERT INTO product (product_name, product_type, price, description,shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, min_purchase, max_purchase, category_ID)
VALUES ('사이다', '음료', 1800, '청량한 탄산음료', '간단한 설명', 0, '칠성', '한국', 'N', 500, SYSDATE+365, '상온', 1, 30, 'CAT000003');


INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('제주 감귤', '식품', 12000, '신선식품 특성상 크기가 일정하지 않을 수 있습니다.', '새콤달콤한 제주 감귤', '겨울 필수 간식 감귤', 10, '제주농협', '국산', 'N', 3000, SYSDATE+20, '냉장', '1박스', 1, 5, DATE '2025-12-05', 'CAT000001');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('부사 사과', '식품', 15000, '보관 시 밀봉하여 냉장 보관하세요.', '아삭하고 당도 높은 부사 사과', '아침에 먹는 금사과', 0, '대구농협', '국산', 'N', 2000, SYSDATE+30, '냉장', '1봉', 1, 3, DATE '2025-12-15', 'CAT000001');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('겨울 시금치', '식품', 3500, '흙이 묻어있으니 세척 후 섭취하세요.', '달고 단단한 겨울 노지 시금치', '영양 가득 시금치', 0, '남해농가', '국산', 'N', 500, SYSDATE+7, '냉장', '1단', 1, 10, DATE '2025-12-10', 'CAT000002');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('핫초코 미트', '음료', 6500, '유통기한을 확인 유의하세요.', '진하고 부드러운 핫초코', '겨울철 따뜻한 코코아', 5, '미트식품', '수입산', 'N', 400, SYSDATE+180, '상온', '1개', 1, 20, DATE '2025-12-22', 'CAT000003');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('레드향', '식품', 28000, '선물용으로 좋은 고급 만감류입니다.', '진한 향과 높은 당도의 레드향', '명절 선물 추천', 0, '서귀포농협', '국산', 'N', 2000, SYSDATE+15, '냉장', '1박스', 1, 2, DATE '2026-01-10', 'CAT000001');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('세척당근', '식품', 4000, '세척되어 있어 편리하게 조리 가능합니다.', '흙 없이 깔끔한 세척당근', '요리 필수 채소', 0, '제주구좌농가', '국산', 'N', 1000, SYSDATE+14, '냉장', '1봉', 1, 5, DATE '2026-01-05', 'CAT000002');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('대파', '식품', 2900, '수령 후 다듬어서 냉동보관하시면 오래 드십니다.', '알싸하고 시원한 국산 대파', '모든 요리의 기본', 10, '진도농가', '국산', 'N', 700, SYSDATE+10, '냉장', '1단', 1, 5, DATE '2026-01-18', 'CAT000002');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('유자차 베이스', '음료', 8000, '개봉 후에는 반드시 냉장 보관하세요.', '겨울에 따뜻하게 즐기는 유자차', '국산 유자로 만든 유자청', 0, '고흥유자영농', '국산', 'N', 1000, SYSDATE+120, '상온', '1병', 1, 5, DATE '2026-01-25', 'CAT000003');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('설향 딸기', '식품', 9900, '딸기는 쉽게 무를 수 있으니 빠르게 드세요.', '새콤달콤 과즙 가득 설향 딸기', '겨울 왕공 딸기', 15, '논산딸기농가', '국산', 'N', 500, SYSDATE+5, '냉장', '1팩', 1, 4, DATE '2026-02-02', 'CAT000001');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('한라봉', '식품', 22000, '후숙 시 당도가 더욱 올라갑니다.', '새콤달콤한 제주 한라봉', '상큼한 비타민 충전', 0, '제주농협', '국산', 'N', 2000, SYSDATE+20, '상온', '1박스', 1, 5, DATE '2026-02-14', 'CAT000001');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('브로콜리', '식품', 2500, '살짝 데쳐서 초고추장에 찍어 드세요.', '영양소가 풍부한 국산 브로콜리', '건강한 그린 푸드', 0, '제주농가', '국산', 'N', 300, SYSDATE+7, '냉장', '1송이', 1, 10, DATE '2026-02-11', 'CAT000002');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('도라지 배즙', '음료', 19000, '침전물이 생길 수 있으나 흔들어 드시면 됩니다.', '기관지에 좋은 도라지 배즙', '환절기 건강 관리', 5, '건강조은', '국산', 'N', 3000, SYSDATE+90, '상온', '30포', 1, 2, DATE '2026-02-20', 'CAT000003');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('짭짤이 토마토', '식품', 18000, '초록빛이 돌 때 먹어야 가장 맛있습니다.', '대저 짭짤이 토마토', '단맛과 짠맛의 조화', 0, '대저농협', '국산', 'N', 1000, SYSDATE+10, '상온', '1박스', 1, 3, DATE '2026-03-05', 'CAT000001');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('봄동 봄나물', '식품', 3000, '겉절이로 무쳐 드시면 맛있습니다.', '봄을 알리는 아삭한 봄동', '입맛 돋우는 봄나물', 10, '해남농가', '국산', 'N', 500, SYSDATE+5, '냉장', '1봉', 1, 5, DATE '2026-03-12', 'CAT000002');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('양파', '식품', 4500, '망에 담아 통풍이 잘되는 곳에 보관하세요.', '단단하고 알이 굵은 국산 양파', '식탁 위 필수 식재료', 0, '무안농협', '국산', 'N', 3000, SYSDATE+30, '상온', '1망', 1, 3, DATE '2026-03-22', 'CAT000002');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('유기농 녹차티백', '음료', 4500, '뜨거운 물에 1~2분 우려내세요.', '은은한 향의 보성 유기농 녹차', '차 한잔의 여유', 0, '보성다원', '국산', 'N', 50, SYSDATE+365, '상온', '20티백', 1, 10, DATE '2026-03-19', 'CAT000003');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('성주 참외', '식품', 14000, '찬물에 씻어 껍질째 혹은 깎아 드세요.', '아삭하고 달콤한 성주 참외', '봄철 대표 과일', 5, '성주농협', '국산', 'N', 1500, SYSDATE+14, '냉장', '1봉', 1, 5, DATE '2026-04-02', 'CAT000001');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('오렌지', '식품', 9900, '강제 왁싱 처리를 하지 않은 안전한 오렌지입니다.', '고당도 네이블 오렌지', '상큼함 가득 고당도 오렌지', 0, '선키스트', '수입산', 'N', 1200, SYSDATE+20, '상온', '1봉', 1, 5, DATE '2026-04-18', 'CAT000001');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('청도 미나리', '식품', 5000, '삼겹살과 곁들이면 최고의 궁합입니다.', '향이 짙은 청도 한재 미나리', '향긋한 봄 미나리', 0, '청도농가', '국산', 'N', 300, SYSDATE+5, '냉장', '1봉', 1, 10, DATE '2026-04-05', 'CAT000002');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('양배추', '식품', 3500, '겉잎을 제거하고 세척 후 사용하세요.', '위 건강에 좋은 싱싱한 양배추', '아삭한 식감 통양배추', 10, '강원농가', '국산', 'N', 1500, SYSDATE+10, '냉장', '1통', 1, 3, DATE '2026-04-15', 'CAT000002');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('콜드브루 원액', '음료', 12000, '반드시 냉장 보관하시고 물이나 우유에 타서 드세요.', '깔끔한 맛의 콜드브루 커피원액', '홈카페 에센셜 콜드브루', 0, '커피팩토리', '수입산', 'N', 500, SYSDATE+60, '냉장', '1병', 1, 5, DATE '2026-04-26', 'CAT000003');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('방울토마토', '식품', 7900, '꼭지를 떼고 보관하시면 더 오래 신선합니다.', '탱글탱글한 대추방울토마토', '한 입에 쏙 건강 간식', 0, '부여농가', '국산', 'N', 1000, SYSDATE+10, '냉장', '1팩', 1, 5, DATE '2026-05-10', 'CAT000001');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('망고', '식품', 15000, '슈가스팟이 생기면 당도가 가장 높습니다.', '달콤하고 부드러운 수입 생망고', '달콤한 열대과일 망고', 20, '글로벌푸드', '수입산', 'N', 1000, SYSDATE+10, '상온', '1팩', 1, 4, DATE '2026-05-20', 'CAT000001');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('다다기오이', '식품', 3900, '표면의 가시에 찔리지 않게 주의하세요.', '수분이 가득하고 아삭한 다다기오이', '오이소박이, 피클용 오이', 0, '진천농가', '국산', 'N', 1000, SYSDATE+7, '냉장', '5개입', 1, 5, DATE '2026-05-04', 'CAT000002');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('파프리카 혼합', '식품', 4900, '색상 비율은 랜덤으로 발송됩니다.', '아삭하고 달콤한 삼색 파프리카', '샐러드 필수 다이어트 채소', 0, '김제농가', '국산', 'N', 500, SYSDATE+7, '냉장', '1봉', 1, 10, DATE '2026-05-18', 'CAT000002');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('아이스티 복숭아', '음료', 5500, '찬물에도 잘 녹는 분말 스틱입니다.', '시원하고 달콤한 복숭아 아이스티', '여름 맞이 시원한 음료', 0, '티타임', '국산', 'N', 500, SYSDATE+365, '상온', '40스틱', 1, 10, DATE '2026-05-28', 'CAT000003');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('고창 수박', '식품', 23000, '수박 특성상 크기 및 당도가 약간 다를 수 있습니다.', '당도 선별 완료된 시원한 고창 수박', '여름 대표 과일 당도보장', 10, '고창농협', '국산', 'N', 7000, SYSDATE+10, '냉장', '1통', 1, 2, DATE '2026-06-15', 'CAT000001');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('신비복숭아', '식품', 16000, '겉은 천도 속은 백도인 신비 복숭아입니다.', '짧은 제철에만 맛보는 신비복숭아', '지금 아니면 못 먹는 복숭아', 0, '경산농가', '국산', 'N', 1000, SYSDATE+7, '냉장', '1팩', 1, 3, DATE '2026-06-22', 'CAT000001');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('초당옥수수', '식품', 19900, '초당옥수수 특성상 끝달림이 좋지 않을 수 있지만 정상상품입니다.', '생으로 먹어도 달콤한 초당옥수수', '아삭하고 달콤한 마약 옥수수', 0, '해남농가', '국산', 'N', 2000, SYSDATE+7, '냉장', '10개', 1, 5, DATE '2026-06-10', 'CAT000002');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('탄산수 플레인', '음료', 11000, '강한 탄산이 매력적인 플레인 탄산수입니다.', '칼로리 걱정 없는 깔끔한 탄산수', '톡 쏘는 청량감', 30, '스파클링', '국산', 'N', 12000, SYSDATE+180, '상온', '24캔', 1, 5, DATE '2026-06-05', 'CAT000003');

INSERT INTO product (product_name, product_type, price, notice, description, shortinfo, discount, manufacturer, origin, underage_purchase, weight, expiration_date, storage_type, UNIT, min_purchase, max_purchase, PRODUCT_INPUT_DATE, category_ID)
VALUES ('유기농 콤부차', '음료', 15000, '냉장 보관 후 차갑게 드시면 더욱 맛있습니다.', '새콤달콤한 유기농 레몬 콤부차', '가볍게 즐기는 발효 음료', 0, '네이처푸드', '국산', 'N', 750, SYSDATE+90, '상온', '1박스', 1, 10, DATE '2026-06-25', 'CAT000003');

/* ===========================
   8.추가정보
=========================== */
INSERT INTO additional_info (info_content, product_id)
VALUES('신선식품의 특성상 상품의 중량에 3%내외의 차이가 발생할 수 있습니다.신선식품 특성상 원물마다 크기 및 형태가 일정하지 않을 수 있습니다.','P000001');

-- 1. P000002 (2개 작성)
INSERT INTO additional_info (info_content, product_id)
VALUES ('본 상품은 냉장 보관 상품이므로 수령 후 즉시 냉장고에 넣어주세요.', 'P000002');
INSERT INTO additional_info (info_content, product_id)
VALUES ('원물 고유의 특성상 모양이 균일하지 않을 수 있으나 품질에는 문제가 없습니다.', 'P000002');

-- 2. P000005 (1개 작성)
INSERT INTO additional_info (info_content, product_id)
VALUES ('껍질째 드실 수 있는 상품이나, 섭취 전 흐르는 물에 깨끗이 세척해 주세요.', 'P000005');

-- 3. P000009 (3개 작성)
INSERT INTO additional_info (info_content, product_id)
VALUES ('개봉 후에는 변질의 우려가 있으니 가급적 빨리 섭취하시기 바랍니다.', 'P000009');
INSERT INTO additional_info (info_content, product_id)
VALUES ('유통기한은 미개봉 상태 기준이며, 보관 조건에 따라 달라질 수 있습니다.', 'P000009');
INSERT INTO additional_info (info_content, product_id)
VALUES ('제품 하단에 침전물이 생길 수 있으나 원료 성분이므로 흔들어 드십시오.', 'P000009');

-- 4. P000012 (2개 작성)
INSERT INTO additional_info (info_content, product_id)
VALUES ('신선식품의 특성상 상품의 중량에 3%내외의 차이가 발생할 수 있습니다.', 'P000012');
INSERT INTO additional_info (info_content, product_id)
VALUES ('기온 변화에 따라 배송 중 약간의 후숙이 진행될 수 있습니다.', 'P000012');

-- 5. P000016 (1개 작성)
INSERT INTO additional_info (info_content, product_id)
VALUES ('이 제품은 알레르기 유발 가능성이 있는 대두, 우유를 사용한 제품과 같은 제조시설에서 생산되었습니다.', 'P000016');

-- 6. P000020 (2개 작성)
INSERT INTO additional_info (info_content, product_id)
VALUES ('장기 보관 시에는 소분하여 냉동 보관하시는 것을 권장합니다.', 'P000020');
INSERT INTO additional_info (info_content, product_id)
VALUES ('조리 전 충분히 해동한 후 사용하셔야 본연의 맛을 느끼실 수 있습니다.', 'P000020');

-- 7. P000024 (1개 작성)
INSERT INTO additional_info (info_content, product_id)
VALUES ('탄산이 포함된 제품으로 흔들 경우 내용물이 넘칠 수 있으니 주의하세요.', 'P000024');

-- 8. P000028 (3개 작성)
INSERT INTO additional_info (info_content, product_id)
VALUES ('초당옥수수 특성상 끝달림이 좋지 않을 수 있지만 정상범주내의 정상상품입니다.', 'P000028');
INSERT INTO additional_info (info_content, product_id)
VALUES ('수령 후 바로 드시지 않을 경우 껍질을 벗겨 냉동 보관해 주세요.', 'P000028');
INSERT INTO additional_info (info_content, product_id)
VALUES ('전자레인지에 3분간 돌려 드시면 가장 아삭하고 달콤하게 즐기실 수 있습니다.', 'P000028');

-- 9. P000031 (2개 작성)
INSERT INTO additional_info (info_content, product_id)
VALUES ('포장 용기의 모서리가 날카로우니 개봉 시 손이 베이지 않도록 주의하십시오.', 'P000031');
INSERT INTO additional_info (info_content, product_id)
VALUES ('직사광선을 피해 서늘하고 건조한 곳에 실온 보관하세요.', 'P000031');

-- 10. P000035 (1개 작성)
INSERT INTO additional_info (info_content, product_id)
VALUES ('충격에 약한 상품이므로 배송 중 미세한 눌림 현상이 발생할 수 있습니다.', 'P000035');

/* ===========================
   5. 상품이미지 (product_img_id 자동생성)
=========================== */
-- P000001
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000001', 'THUMB', 'http://.../p1_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000001', 'DETAIL', 'http://.../p1_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000001', 'CONTENT', 'http://.../p1_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000001', 'CONTENT', 'http://.../p1_content2.jpg');

-- P000002
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000002', 'THUMB', 'http://.../p2_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000002', 'DETAIL', 'http://.../p2_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000002', 'CONTENT', 'http://.../p2_content1.jpg');

-- P000003
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000003', 'THUMB', 'http://.../p3_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000003', 'DETAIL', 'http://.../p3_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000003', 'CONTENT', 'http://.../p3_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000003', 'CONTENT', 'http://.../p3_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000003', 'CONTENT', 'http://.../p3_content3.jpg');

-- P000004
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000004', 'THUMB', 'http://.../p4_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000004', 'DETAIL', 'http://.../p4_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000004', 'CONTENT', 'http://.../p4_content1.jpg');

-- P000005
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000005', 'THUMB', 'http://.../p5_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000005', 'DETAIL', 'http://.../p5_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000005', 'CONTENT', 'http://.../p5_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000005', 'CONTENT', 'http://.../p5_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000005', 'CONTENT', 'http://.../p5_content3.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000005', 'CONTENT', 'http://.../p5_content4.jpg');

-- P000006
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000006', 'THUMB', 'http://.../p6_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000006', 'DETAIL', 'http://.../p6_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000006', 'CONTENT', 'http://.../p6_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000006', 'CONTENT', 'http://.../p6_content2.jpg');

-- P000007
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000007', 'THUMB', 'http://.../p7_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000007', 'DETAIL', 'http://.../p7_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000007', 'CONTENT', 'http://.../p7_content1.jpg');

-- P000008
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000008', 'THUMB', 'http://.../p8_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000008', 'DETAIL', 'http://.../p8_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000008', 'CONTENT', 'http://.../p8_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000008', 'CONTENT', 'http://.../p8_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000008', 'CONTENT', 'http://.../p8_content3.jpg');

-- P000009
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000009', 'THUMB', 'http://.../p9_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000009', 'DETAIL', 'http://.../p9_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000009', 'CONTENT', 'http://.../p9_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000009', 'CONTENT', 'http://.../p9_content2.jpg');

-- P000010
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000010', 'THUMB', 'http://.../p10_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000010', 'DETAIL', 'http://.../p10_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000010', 'CONTENT', 'http://.../p10_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000010', 'CONTENT', 'http://.../p10_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000010', 'CONTENT', 'http://.../p10_content3.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000010', 'CONTENT', 'http://.../p10_content4.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000010', 'CONTENT', 'http://.../p10_content5.jpg');

-- P000011
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000011', 'THUMB', 'http://.../p11_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000011', 'DETAIL', 'http://.../p11_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000011', 'CONTENT', 'http://.../p11_content1.jpg');

-- P000012
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000012', 'THUMB', 'http://.../p12_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000012', 'DETAIL', 'http://.../p12_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000012', 'CONTENT', 'http://.../p12_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000012', 'CONTENT', 'http://.../p12_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000012', 'CONTENT', 'http://.../p12_content3.jpg');

-- P000013
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000013', 'THUMB', 'http://.../p13_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000013', 'DETAIL', 'http://.../p13_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000013', 'CONTENT', 'http://.../p13_content1.jpg');

-- P000014
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000014', 'THUMB', 'http://.../p14_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000014', 'DETAIL', 'http://.../p14_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000014', 'CONTENT', 'http://.../p14_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000014', 'CONTENT', 'http://.../p14_content2.jpg');

-- P000015
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000015', 'THUMB', 'http://.../p15_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000015', 'DETAIL', 'http://.../p15_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000015', 'CONTENT', 'http://.../p15_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000015', 'CONTENT', 'http://.../p15_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000015', 'CONTENT', 'http://.../p15_content3.jpg');

-- P000016
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000016', 'THUMB', 'http://.../p16_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000016', 'DETAIL', 'http://.../p16_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000016', 'CONTENT', 'http://.../p16_content1.jpg');

-- P000017
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000017', 'THUMB', 'http://.../p17_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000017', 'DETAIL', 'http://.../p17_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000017', 'CONTENT', 'http://.../p17_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000017', 'CONTENT', 'http://.../p17_content2.jpg');

-- P000018
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000018', 'THUMB', 'http://.../p18_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000018', 'DETAIL', 'http://.../p18_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000018', 'CONTENT', 'http://.../p18_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000018', 'CONTENT', 'http://.../p18_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000018', 'CONTENT', 'http://.../p18_content3.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000018', 'CONTENT', 'http://.../p18_content4.jpg');

-- P000019
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000019', 'THUMB', 'http://.../p19_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000019', 'DETAIL', 'http://.../p19_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000019', 'CONTENT', 'http://.../p19_content1.jpg');

-- P000020
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000020', 'THUMB', 'http://.../p20_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000020', 'DETAIL', 'http://.../p20_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000020', 'CONTENT', 'http://.../p20_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000020', 'CONTENT', 'http://.../p20_content2.jpg');

-- P000021
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000021', 'THUMB', 'http://.../p21_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000021', 'DETAIL', 'http://.../p21_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000021', 'CONTENT', 'http://.../p21_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000021', 'CONTENT', 'http://.../p21_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000021', 'CONTENT', 'http://.../p21_content3.jpg');

-- P000022
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000022', 'THUMB', 'http://.../p22_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000022', 'DETAIL', 'http://.../p22_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000022', 'CONTENT', 'http://.../p22_content1.jpg');

-- P000023
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000023', 'THUMB', 'http://.../p23_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000023', 'DETAIL', 'http://.../p23_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000023', 'CONTENT', 'http://.../p23_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000023', 'CONTENT', 'http://.../p23_content2.jpg');

-- P000024
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000024', 'THUMB', 'http://.../p24_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000024', 'DETAIL', 'http://.../p24_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000024', 'CONTENT', 'http://.../p24_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000024', 'CONTENT', 'http://.../p24_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000024', 'CONTENT', 'http://.../p24_content3.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000024', 'CONTENT', 'http://.../p24_content4.jpg');

-- P000025
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000025', 'THUMB', 'http://.../p25_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000025', 'DETAIL', 'http://.../p25_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000025', 'CONTENT', 'http://.../p25_content1.jpg');

-- P000026
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000026', 'THUMB', 'http://.../p26_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000026', 'DETAIL', 'http://.../p26_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000026', 'CONTENT', 'http://.../p26_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000026', 'CONTENT', 'http://.../p26_content2.jpg');

-- P000027
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000027', 'THUMB', 'http://.../p27_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000027', 'DETAIL', 'http://.../p27_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000027', 'CONTENT', 'http://.../p27_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000027', 'CONTENT', 'http://.../p27_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000027', 'CONTENT', 'http://.../p27_content3.jpg');

-- P000028
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000028', 'THUMB', 'http://.../p28_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000028', 'DETAIL', 'http://.../p28_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000028', 'CONTENT', 'http://.../p28_content1.jpg');

-- P000029
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000029', 'THUMB', 'http://.../p29_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000029', 'DETAIL', 'http://.../p29_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000029', 'CONTENT', 'http://.../p29_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000029', 'CONTENT', 'http://.../p29_content2.jpg');

-- P000030
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000030', 'THUMB', 'http://.../p30_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000030', 'DETAIL', 'http://.../p30_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000030', 'CONTENT', 'http://.../p30_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000030', 'CONTENT', 'http://.../p30_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000030', 'CONTENT', 'http://.../p30_content3.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000030', 'CONTENT', 'http://.../p30_content4.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000030', 'CONTENT', 'http://.../p30_content5.jpg');

-- P000031
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000031', 'THUMB', 'http://.../p31_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000031', 'DETAIL', 'http://.../p31_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000031', 'CONTENT', 'http://.../p31_content1.jpg');

-- P000032
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000032', 'THUMB', 'http://.../p32_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000032', 'DETAIL', 'http://.../p32_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000032', 'CONTENT', 'http://.../p32_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000032', 'CONTENT', 'http://.../p32_content2.jpg');

-- P000033
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000033', 'THUMB', 'http://.../p33_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000033', 'DETAIL', 'http://.../p33_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000033', 'CONTENT', 'http://.../p33_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000033', 'CONTENT', 'http://.../p33_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000033', 'CONTENT', 'http://.../p33_content3.jpg');

-- P000034
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000034', 'THUMB', 'http://.../p34_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000034', 'DETAIL', 'http://.../p34_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000034', 'CONTENT', 'http://.../p34_content1.jpg');

-- P000035
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000035', 'THUMB', 'http://.../p35_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000035', 'DETAIL', 'http://.../p35_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000035', 'CONTENT', 'http://.../p35_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000035', 'CONTENT', 'http://.../p35_content2.jpg');

-- P000036
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000036', 'THUMB', 'http://.../p36_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000036', 'DETAIL', 'http://.../p36_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000036', 'CONTENT', 'http://.../p36_content1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000036', 'CONTENT', 'http://.../p36_content2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000036', 'CONTENT', 'http://.../p36_content3.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000036', 'CONTENT', 'http://.../p36_content4.jpg');

-- P000037
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000037', 'THUMB', 'http://.../p37_thumb.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000037', 'DETAIL', 'http://.../p37_detail.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000037', 'CONTENT', 'http://.../p37_content1.jpg');



/* ===========================
   7. 상품 옵션 (option_id 자동생성: OPT000001...)
=========================== */
-- 장바구니 및 주문상세에서 활용하기 위해 기본 옵션을 추가했습니다.
INSERT INTO product_option (option_name, extra_charge, stockQuantity, product_id) VALUES ('기본 사과', 0, 100, 'P000001'); -- OPT000001
INSERT INTO product_option (option_name, extra_charge, stockQuantity, product_id) VALUES ('기본 당근', 0, 150, 'P000002'); -- OPT000002
INSERT INTO product_option (option_name, extra_charge, stockQuantity, product_id) VALUES ('기본 콜라', 0, 200, 'P000003'); -- OPT000003
INSERT INTO product_option (option_name, extra_charge, stockQuantity, product_id) VALUES ('기본 바나나', 0, 80, 'P000004'); -- OPT000004
INSERT INTO product_option (option_name, extra_charge, stockQuantity, product_id) VALUES ('기본 양파', 0, 120, 'P000005'); -- OPT000005
INSERT INTO product_option (option_name, extra_charge, stockQuantity, product_id) VALUES ('기본 사이다', 0, 300, 'P000006'); -- OPT000006


/* ===========================
   3. 장바구니 (cart_ID 자동생성, client_No 매핑)
=========================== */
INSERT INTO shopping_cart (quantity, client_No, option_ID) VALUES (2, 'C000001', 'OPT000001');
INSERT INTO shopping_cart (quantity, client_No, option_ID) VALUES (1, 'C000002', 'OPT000002');
INSERT INTO shopping_cart (quantity, client_No, option_ID) VALUES (3, 'C000003', 'OPT000003');


/* ===========================
   9. 주문 (order_ID 자동생성: O000001, O000002...)
=========================== */
INSERT INTO orders (total_amount, order_status, delivery_status, delivery_request, delivery_start_date, delivery_completion_date, client_No)
VALUES (25000, '일반배송', '배송완료', '배송요청사항없음', DATE '2026-06-06', DATE '2026-06-08', 'C000001');

INSERT INTO orders (total_amount, order_status, delivery_status, delivery_request, delivery_start_date, client_No)
VALUES (47000, '일반배송', '배송중', '배송요청사항없음', DATE '2026-06-08', 'C000002');

INSERT INTO orders (total_amount, order_status, delivery_status, delivery_request, delivery_start_date, client_No)
VALUES (80000, '일반배송', '배송대기', '배송요청사항없음', DATE '2026-06-10', 'C000003');


/* ===========================
   10. 주문상세 (order_details_ID 자동생성: OD000001...)
=========================== */
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 25000, 'OPT000001', 'O000001'); -- OD000001
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 12000, 'OPT000002', 'O000002'); -- OD000002
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 33000, 'OPT000003', 'O000002'); -- OD000003
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 2000,  'OPT000004', 'O000002'); -- OD000004
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 16000, 'OPT000006', 'O000003'); -- OD000005
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 64000, 'OPT000004', 'O000003'); -- OD000006
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 64000, 'OPT000004', 'O000003'); -- OD000006
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 64000, 'OPT000005', 'O000003'); -- OD000006
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 64000, 'OPT000005', 'O000003'); -- OD000006
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 64000, 'OPT000005', 'O000003'); -- OD000006
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 64000, 'OPT000006', 'O000003'); -- OD000006
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 64000, 'OPT000006', 'O000003'); -- OD000006
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 64000, 'OPT000006', 'O000003'); -- OD000006
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 64000, 'OPT000006', 'O000003'); -- OD000006
INSERT INTO order_details (quantity, price, option_ID, order_ID) VALUES (1, 64000, 'OPT000006', 'O000003'); -- OD000006


/* ===========================
   11. 결제 (paymentID 자동생성)
=========================== */
INSERT INTO payment (order_ID, payment_type, payment_date) VALUES ('O000001', '일반결제', DATE '2026-06-06');
INSERT INTO payment (order_ID, payment_type, payment_date) VALUES ('O000002', '자동결제', DATE '2026-06-08');
INSERT INTO payment (order_ID, payment_type, payment_date) VALUES ('O000003', '브랜드페이', DATE '2026-06-10');


/* ===========================
   13. 배송지 (delivery_ID 자동생성: DLV000001...)
=========================== */
-- 주의: select_delivery가 참조할 ID가 먼저 생성되어야 하므로 순서를 바꿨습니다.
INSERT INTO delivery_destination (delivery_postcode, delivery_addr, first_destination, client_No)
VALUES ('05800', '서울시 송파구 문정동', 'T', 'C000001'); -- DLV000001

INSERT INTO delivery_destination (delivery_postcode, delivery_addr, first_destination, client_No)
VALUES ('05820', '서울시 송파구 장지동', 'F', 'C000001'); -- DLV000002


/* ===========================
   12. 선택배송지 (매핑 테이블)
=========================== */
INSERT INTO select_delivery (delivery_ID, order_ID) VALUES ('DLV000001', 'O000001');
INSERT INTO select_delivery (delivery_ID, order_ID) VALUES ('DLV000001', 'O000002');
INSERT INTO select_delivery (delivery_ID, order_ID) VALUES ('DLV000002', 'O000003');


/* ===========================
   15. 문의유형 (inquiry_code 자동생성: TYP000001...)
=========================== */
-- 문의내역 테이블보다 먼저 들어가야 에러가 안 납니다.
INSERT INTO inquiry_type (inquiry_name, inquiry_type) VALUES ('배송지연관련', '1대1 문의'); -- TYP000001
INSERT INTO inquiry_type (inquiry_name, inquiry_type) VALUES ('상품상세문의', '상품 문의');   -- TYP000002


/* ===========================
   14. 문의 (inquiry_ID 자동생성)
=========================== */
INSERT INTO inquiry (inquiry_date, inquiry_title, inquiry_secret, inquiry_content, answer_status, answer, answer_date, inquiry_code, order_details_ID)
VALUES (SYSDATE, '배송이 안 와요', 'T', '언제 오나요?', '답변완료', '조금만 기다려주세요.', SYSDATE, 'TYP000001', 'OD000003');

INSERT INTO inquiry (inquiry_date, inquiry_title, inquiry_secret, inquiry_content, answer_status, inquiry_code, order_details_ID)
VALUES (SYSDATE, '유통기한 문의', 'F', '언제까지인가요?', '대기중', 'TYP000002', 'OD000003');

INSERT INTO inquiry (inquiry_date, inquiry_title, inquiry_secret, inquiry_content, answer_status, inquiry_code, order_details_ID)
VALUES (SYSDATE, '재입고 일정', 'T', '재입고 언제 되죠?', '대기중', 'TYP000002', 'OD000003');


/* ===========================
   16. 클레임 (claim_ID 자동생성: CLM000001...)
=========================== */
INSERT INTO claim (claim_type, requestdate, reason, reason_detail, status, processingdate, order_details_ID)
VALUES ('환불', SYSDATE-5, '상품 파손', '배송 중 상품이 파손되어 환불 요청', '처리완료', SYSDATE-3, 'OD000001');

INSERT INTO claim (claim_type, requestdate, reason, reason_detail, status, processingdate, order_details_ID)
VALUES ('교환', SYSDATE-2, '오배송', '주문한 상품과 다른 상품이 배송됨', '처리중', NULL, 'OD000003');

INSERT INTO claim (claim_type, requestdate, reason, reason_detail, status, processingdate, order_details_ID)
VALUES ('반품', SYSDATE-1, '단순변심', '생각했던 상품과 달라 반품 요청', '접수완료', NULL, 'OD000005');


/* ===========================
   17. 클레임이미지 (claim_img_ID 자동생성)
=========================== */
INSERT INTO claim_image (claim_ID, file_name) VALUES ('CLM000001', 'damage1.jpg');
INSERT INTO claim_image (claim_ID, file_name) VALUES ('CLM000002', 'wrong_item.jpg');
INSERT INTO claim_image (claim_ID, file_name) VALUES ('CLM000003', 'return_request.jpg');

COMMIT;
