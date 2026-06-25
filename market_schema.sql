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
	product_id VARCHAR2(500), /* 상품아이디　*/
	order_details_id VARCHAR2(30) /* 주무상세아이디　*/
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

ALTER TABLE product_option
	ADD
		CONSTRAINT FK_order_details_TO_product_option
		FOREIGN KEY (
			order_details_ID
		)
		REFERENCES order_details (
			order_details_ID
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


/* ===========================
   8.추가정보
=========================== */
INSERT INTO additional_info (info_content, product_id)
VALUES('신선식품의 특성상 상품의 중량에 3%내외의 차이가 발생할 수 있습니다.신선식품 특성상 원물마다 크기 및 형태가 일정하지 않을 수 있습니다.','P000001');


/* ===========================
   5. 상품이미지 (product_img_id 자동생성)
=========================== */
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000001', 'MAIN', 'http://.../p1.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000002', 'MAIN', 'http://.../p2.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000003', 'MAIN', 'http://.../p3.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000004', 'MAIN', 'http://.../p4.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000005', 'MAIN', 'http://.../p5.jpg');
INSERT INTO product_image (product_ID, image_type, URL) VALUES ('P000006', 'MAIN', 'http://.../p6.jpg');


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
