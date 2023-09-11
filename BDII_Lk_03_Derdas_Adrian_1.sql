
PROMPT ------------------------------------------------------
PROMPT   BAZY DANYCH II - Lk_03 w2
PROMPT        
PROMPT   Zakres SQL - ERD -> PDM -> DDL
PROMPT  
PROMPT   DB server: Oracle 12c
PROMPT 
PROMPT   Script v. 1.1
PROMPT 
PROMPT ------------------------------------------------------



------------------------------------------------------
--                 PDM wersja 2
-- encje specjalizowane tworzą jedną tabelę w bazie danych
--
-- prefix tabel: studenci: w2_
-- 


CLEAR SCREEN;
--
SET LINESIZE 450;
SET PAGESIZE 300;

-- Nagrywanie konunikatów z buforu ekranowego do pliku
SPOOL "C:\Users\Adrian\Desktop\SQL_TEST\BDII_Lk_03_Derdas_Adrian_1.out.txt"

show user;


SET SERVEROUTPUT ON;

alter session set 
	nls_date_format = 'YYYY-MM-DD';

--
select sysdate from dual;
--

---------------------------
PROMPT   sekwencja kasowania
---------------------------
drop table w2_TYP_PALIWA;

drop table w2_PODZESPOLY;
drop table w2_PRODUCENCI;
drop table w2_AAA_SPO_SER;
drop table w2_BBB_PRA_SER;
drop table w2_CCC_BOL_SER;
drop table w2_SERWIS;
drop table w2_PRACOW_SERW;
drop table w2_SPONSOR;
drop table w2_BOLIDY;


PROMPT ---------------------------
PROMPT   DDL create table
PROMPT ---------------------------	

---------------------------
-- table w2_TYP_PALIWA
---------------------------	
create table w2_TYP_PALIWA (
TYP_NAZWA varchar2(20) NOT NULL,
TYP_OPIS varchar2(50)
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

ALTER TABLE w2_TYP_PALIWA NOLOGGING;

------------------------
-- PRIMARY KEY
------------------------
ALTER TABLE w2_TYP_PALIWA
	ADD CONSTRAINT PK_w2_TYP_PALIWA
	PRIMARY KEY (TYP_NAZWA) 
	USING INDEX
PCTFREE 1
TABLESPACE STUDENT_INDEX 
NOLOGGING;

------------------------
-- DML w2_TYP_PALIWA
------------------------
INSERT INTO w2_TYP_PALIWA(TYP_NAZWA,TYP_OPIS) VALUES ('Nazwa1','Opis1');
INSERT INTO w2_TYP_PALIWA(TYP_NAZWA,TYP_OPIS) VALUES ('Nazwa2','Opis2');

--SELECT * FROM w2_TYP_PALIWA;
/*
TYP_NAZWA            TYP_OPIS                                        
-------------------- --------------------------------------------------
Nazwa1               Opis1                                             
Nazwa2               Opis2                                             
*/


---------------------------
PROMPT   table w2_SPONSOR
---------------------------	
create table w2_SPONSOR (
SPO_ID			number(8)		NOT NULL,
SPO_NAZWA		varchar2(128)	NOT NULL,
SPO_REGON		varchar2(10)	NOT NULL,
SPO_NIP			varchar2(10)	NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

ALTER TABLE w2_SPONSOR NOLOGGING;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE w2_SPONSOR 
		ADD CONSTRAINT PK_w2_SPONSOR
		PRIMARY KEY (SPO_ID)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;
	
	-- ----------------------#
	--  UNIQUE Keys;
	-- ----------------------#
	ALTER TABLE w2_SPONSOR
	ADD CONSTRAINT UQ1_w2_SPONSOR
		UNIQUE (SPO_NAZWA)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;
	
	-- ----------------------#
	--  UNIQUE Keys;
	-- ----------------------#
	ALTER TABLE w2_SPONSOR
	ADD CONSTRAINT UQ2_w2_SPONSOR
		UNIQUE (SPO_REGON)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;
	
	-- ----------------------#
	--  UNIQUE Keys;
	-- ----------------------#
	ALTER TABLE w2_SPONSOR
	ADD CONSTRAINT UQ3_w2_SPONSOR
		UNIQUE (SPO_NIP)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;

		
	------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_w2_SPONSOR;
	
	CREATE SEQUENCE SEQ_w2_SPONSOR 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_BI_w2_SPONSOR
	BEFORE INSERT ON w2_SPONSOR
	FOR EACH ROW
	BEGIN
		IF :NEW.SPO_ID IS NULL THEN
			SELECT SEQ_w2_SPONSOR.NEXTVAL 
				INTO :NEW.SPO_ID FROM DUAL;
		END IF;
		--
		-- DBMS_OUTPUT.PUT_LINE('Dodano nowy wiersz do w2_SERWIS - SPO_ID='||:NEW.MIE_ID);
		--
	END;
	/		
	
	-- TEST DZIAŁANIA WYZWALACZY -- KONIECZNY!
	
	------------------------
	-- DML w2_SPONSOR
	------------------------
	insert into w2_SPONSOR (SPO_NAZWA,SPO_REGON,SPO_NIP)
	values ('AUTOPARTNER',123456789,1234567890);

	insert into w2_SPONSOR (SPO_NAZWA,SPO_REGON,SPO_NIP)
	values ('INTERCARS',123456788,1234567899);

	insert into w2_SPONSOR (SPO_NAZWA,SPO_REGON,SPO_NIP)
	values ('SHELL',113456789,1134567890);
	
	column SPO_ID HEADING 'ID' for 999999
	column SPO_NAZWA HEADING 'NAZWA' for A30
	column SPO_REGON HEADING 'REGON' for A30
	column SPO_NIP HEADING 'NIP' for A30

	-- ile wierszy
	select count(*) from w2_SPONSOR;

	-- szybciej:
	select count(SPO_ID) from w2_SPONSOR;

	select SPO_ID,SPO_NAZWA,SPO_REGON,SPO_NIP from w2_SPONSOR;
	/*
	
	SPO_ID NAZWA                          REGON                          NIP
---------- ------------------------------ ------------------------------ ------------------------------
         1 AUTOPARTNER                    123456789                      1234567890
         2 INTERCARS                      123456788                      1234567899
         3 SHELL                          113456789                      1134567890
	*/
	
										
---------------------------
PROMPT   table w2_PRACOW_SERW
---------------------------	
create table w2_PRACOW_SERW (
PRA_ID					number(8)		NOT NULL,
PRA_IMIE				varchar2(32)	NOT NULL,
PRA_NAZWISKO 			varchar2(32),	
PRA_DATA_ZATRUDNIENIA	DATE,
PRA_UMOWA				varchar2(40),	
PRA_PESEL 				varchar2(11)	NOT NULL	
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

ALTER TABLE w2_PRACOW_SERW NOLOGGING;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE w2_PRACOW_SERW 
		ADD CONSTRAINT PK_w2_PRACOW_SERW 
		PRIMARY KEY (PRA_ID) 
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;

	-- ----------------------#
	--  UNIQUE Keys;
	-- ----------------------#
	ALTER TABLE w2_PRACOW_SERW
	ADD CONSTRAINT UQ_w2_PRACOW_SERW 
		UNIQUE (PRA_PESEL)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;
		
	------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_w2_PRACOW_SERW;
	
	CREATE SEQUENCE SEQ_w2_PRACOW_SERW 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_BI_w2_PRACOW_SERW
	BEFORE INSERT ON w2_PRACOW_SERW
	FOR EACH ROW
	BEGIN
		IF :NEW.PRA_ID IS NULL THEN
			SELECT SEQ_w2_PRACOW_SERW.NEXTVAL 
				INTO :NEW.PRA_ID FROM DUAL;
		END IF;
		--
	END;
	/

	------------------------
	-- DML w2_PRACOW_SERW
	------------------------	
	insert into w2_PRACOW_SERW(PRA_IMIE,PRA_NAZWISKO,PRA_DATA_ZATRUDNIENIA)
	values ('HENRYK', 'KOWALSKI','2016-07-06'); 	

	insert into w2_PRACOW_SERW(PRA_IMIE,PRA_NAZWISKO,PRA_DATA_ZATRUDNIENIA)
	values ('MARIUSZ', 'SZCZECINSKI','2012-01-15');

	insert into w2_PRACOW_SERW(PRA_IMIE,PRA_NAZWISKO,PRA_DATA_ZATRUDNIENIA)
	values ('MATEUSZ', 'KRAWCZYK','2003-01-15');

	insert into w2_PRACOW_SERW(PRA_IMIE,PRA_NAZWISKO,PRA_DATA_ZATRUDNIENIA)
	values ('ZDZISLAW', 'KRASNODEBSKI','1999-01-15');	

		-- szybciej:
		-- select count(PRA_ID) from w2_PRACOW_SERW;

		
	column PRA_ID HEADING 'ID' for 9999
	column PRA_IMIE HEADING 'IMIE' for A15
	column PRA_NAZWISKO HEADING 'NAZWISKO' for A15
	column PRA_DATA_ZATRUDNIENIA HEADING 'DATA ZATRUDNIENIA' for A20
		
	select * from w2_PRACOW_SERW;
			
	/* Wyniki zapytań wklejamy do skryptu w komentarzach wielowierszowych!!! */
	/*
	  ID IMIE            NAZWISKO        DATA ZATRUDNIENIA
----- --------------- --------------- --------------------
    1 HENRYK          KOWALSKI        2016-07-06
    2 MARIUSZ         SZCZECINSKI     2012-01-15
    3 MATEUSZ         KRAWCZYK        2003-01-15
    4 ZDZISLAW        KRASNODEBSKI    1999-01-15
	*/

---------------------------
PROMPT   table w2_SERWIS
---------------------------	
create table w2_SERWIS (
SER_ID			number(8)		NOT NULL,
SER_MIASTO 		varchar2(80),
SER_UWAGI		varchar2(80)
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

ALTER TABLE w2_SERWIS NOLOGGING;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE w2_SERWIS 
		ADD CONSTRAINT PK_w2_SERWIS 
		PRIMARY KEY (SER_ID) 
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;

	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE w2_SERWIS
		ADD CONSTRAINT FK1_w2_SERWIS
		FOREIGN KEY(PRA_ID) 
		REFERENCES w2_PRACOW_SERW(PRA_ID) ENABLE;

	ALTER TABLE w2_SERWIS
		ADD CONSTRAINT FK2_w2_SERWIS
		FOREIGN KEY(SPO_ID) 
		REFERENCES w2_SPONSOR(SPO_ID) ENABLE;

	------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_w2_SERWIS;
	
	CREATE SEQUENCE SEQ_w2_SERWIS 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;


	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_BI_w2_SERWIS
	BEFORE INSERT ON w2_SERWIS
	FOR EACH ROW
	BEGIN
		IF :NEW.SER_ID IS NULL THEN
			SELECT SEQ_w2_SERWIS.NEXTVAL 
				INTO :NEW.SER_ID FROM DUAL;
		END IF;
		--
	END;
	/

---------------------------
PROMPT   table w2_AAA_SPO_SER
---------------------------	
create table w2_AAA_SPO_SER (
AAA_ID					number(8)		NOT NULL,
SER_ID					number(8)		NOT NULL,
SPO_ID					number(8)		NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

ALTER TABLE w2_AAA_SPO_SER NOLOGGING;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE w2_AAA_SPO_SER 
		ADD CONSTRAINT PK_w2_AAA_SPO_SER
		PRIMARY KEY (AAA_ID) 
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;
	
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE w2_PODZESPOLY
		ADD CONSTRAINT FK2_w2_PODZESPOLY
		FOREIGN KEY(SER_ID) 
		REFERENCES w2_SERWIS(SER_ID) ENABLE;
		
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE w2_PODZESPOLY
		ADD CONSTRAINT FK2_w2_PODZESPOLY
		FOREIGN KEY(SPO_ID) 
		REFERENCES w2_SPONSOR(SPO_ID) ENABLE;	
		
	------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_w2_AAA_SPO_SER;
	
	CREATE SEQUENCE SEQ_w2_AAA_SPO_SER 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_BI_w2_AAA_SPO_SER
	BEFORE INSERT ON w2_AAA_SPO_SER
	FOR EACH ROW
	BEGIN
		IF :NEW.AAA_ID IS NULL THEN
			SELECT SEQ_w2_AAA_SPO_SER.NEXTVAL 
				INTO :NEW.AAA_ID FROM DUAL;
		END IF;
		--
	END;
	/

	------------------------
	-- DML w2_AAA_SPO_SER
	------------------------	
	insert into w2_AAA_SPO_SER(SER_ID,SPO_ID)
	values (1,1); 	

	insert into w2_AAA_SPO_SER(SER_ID,SPO_ID)
	values (2,2); 

		-- szybciej:
		select count(PRO_ID) from w2_AAA_SPO_SER;

		
	column AAA_ID HEADING 'ID' for 9999
	column SER_ID HEADING 'ID SERWIS' for 9999
	column SPO_ID HEADING 'ID SPONSOR' for 9999
		
	select * from w2_AAA_SPO_SER;
	
	
	/*
	   ID ID SERWIS     ID SPONSOR
	----- ------------- -------------
		1             1             1 
		2             2             2 
	
	*/

---------------------------
PROMPT   table w2_BBB_PRA_SER
---------------------------	
create table w2_BBB_PRA_SER (
BBB_ID					number(8)		NOT NULL,
SER_ID					number(8)		NOT NULL,
PRA_ID					number(8)		NOT NULL
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

ALTER TABLE w2_BBB_PRA_SER NOLOGGING;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE w2_BBB_PRA_SER 
		ADD CONSTRAINT PK_w2_BBB_PRA_SER 
		PRIMARY KEY (BBB_ID) 
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;
	
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE w2_PODZESPOLY
		ADD CONSTRAINT FK2_w2_PODZESPOLY
		FOREIGN KEY(SER_ID) 
		REFERENCES w2_SERWIS(SER_ID) ENABLE;
		
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE w2_PODZESPOLY
		ADD CONSTRAINT FK2_w2_PODZESPOLY
		FOREIGN KEY(PRA_ID) 
		REFERENCES w2_PRACOW_SERW(PRA_ID) ENABLE;	
		
	------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_w2_BBB_PRA_SER;
	
	CREATE SEQUENCE SEQ_w2_BBB_PRA_SER 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;

	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_BI_w2_BBB_PRA_SER
	BEFORE INSERT ON w2_BBB_PRA_SER
	FOR EACH ROW
	BEGIN
		IF :NEW.BBB_ID IS NULL THEN
			SELECT SEQ_w2_BBB_PRA_SER.NEXTVAL 
				INTO :NEW.BBB_ID FROM DUAL;
		END IF;
		--
	END;
	/

	------------------------
	-- DML w2_BBB_PRA_SER
	------------------------	
	insert into w2_BBB_PRA_SER(SER_ID,PRA_ID)
	values (1,1); 	

	insert into w2_BBB_PRA_SER(SER_ID,PRA_ID)
	values (2,2); 

		-- szybciej:
		select count(PRO_ID) from w2_BBB_PRA_SER;

		
	column BBB_ID HEADING 'ID' for 9999
	column SER_ID HEADING 'ID SERWIS' for 9999
	column PRA_ID HEADING 'ID PRACOWNIK' for 9999
		
	select * from w2_BBB_PRA_SER;
	
	
	/*
	   ID ID SERWIS     ID PRACOWNIK
	----- ------------- -------------
		1             1             1 
		2             2             2 
	
	*/
	
---------------------------
PROMPT   table w2_CCC_BOL_SER
---------------------------	
create table w2_CCC_BOL_SER (
CCC_ID					number(8)		NOT NULL,
SER_ID					number(8)		NOT NULL,
BOL_ID					number(8)		NOT NULL,
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

ALTER TABLE w2_CCC_BOL_SER NOLOGGING;	

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE w2_CCC_BOL_SER 
		ADD CONSTRAINT PK_w2_CCC_BOL_SER 
		PRIMARY KEY (CCC_ID) 
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;
	
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE w2_CCC_BOL_SER 
		ADD CONSTRAINT FK1_w2_CCC_BOL_SER 
		FOREIGN KEY(SER_ID) 
		REFERENCES w2_SERWIS(SER_ID) ENABLE;
		
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE w2_CCC_BOL_SER 
		ADD CONSTRAINT FK2_w2_CCC_BOL_SER 
		FOREIGN KEY(BOL_ID) 
		REFERENCES w2_BOLIDY(BOL_ID) ENABLE;	
	
	------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_w2_CCC_BOL_SER;
	
	CREATE SEQUENCE SEQ_w2_CCC_BOL_SER 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	--
	-- UWAGA! Wyzwalacz realizuje funkcję "DISTINCT" dla osoby fizycznej i firmy z encji specjalizowanych!
	
	CREATE OR REPLACE TRIGGER T_BI_w2_CCC_BOL_SER
	BEFORE INSERT ON w2_CCC_BOL_SER
	FOR EACH ROW
	DECLARE
		EX_BOL1 EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_BOL1,-20001);
	BEGIN
		IF :NEW.CCC_ID IS NULL THEN
			SELECT SEQ_w2_CCC_BOL_SER.NEXTVAL 
				INTO :NEW.CCC_ID FROM DUAL;
		END IF;
		--
		IF (:NEW.BOL_ID IS NOT NULL and :NEW.BEL_ID IS NULL) 
			or (:NEW.BOL_ID IS NULL and :NEW.BEL_ID IS NOT NULL)
			THEN
				NULL;
		ELSE
			RAISE_APPLICATION_ERROR(-20001,'T_BI_w2_CCC_BOL_SER: Err! Wprowadz ID DLA POJAZDU ELEKTRYCZNEGO ALBO ID DLA POJAZDU SPALINOWEGO!');
		END IF;
		--
	END;
	/
	------------------------
	-- DML w2_CCC_BOL_SER
	------------------------	
	insert into w2_CCC_BOL_SER(SER_ID,BOL_ID)
	values (1,1); 	

	insert into w2_CCC_BOL_SER(SER_ID,BEL_ID)
	values (2,2); 

		-- szybciej:
		select count(PRO_ID) from w2_CCC_BOL_SER;

		
	column AAA_ID HEADING 'ID' for 9999
	column SER_ID HEADING 'ID SERWIS' for 9999
	column BOL_ID HEADING 'ID BOLIDY ELEKTRYCZNE' for 9999
	column BEL_ID HEADING 'ID BOLIDY SPALINOWE' for 9999
		
	select * from w2_CCC_BOL_SER;
	
	
	/*
	   ID ID SERWIS     ID BOLIDY ELEKTRYCZNE  ID BOLIDY SPALINOWE
	----- ------------- ---------------------- -------------------
		1             1                                          1 
		2             2                      2 
	
	*/
	
	PROMPT BLEDNE DANE - TEST WYZWALACZA

	insert into w2_CCC_BOL_SER(SER_ID,BOL_ID,BEL_ID)
	values (2,2,1); 
	/*
	ERROR at line 1:
	ORA-20001: T_BI_w2_CCC_BOL_SER: T_BI_w2_CCC_BOL_SER: Err! Wprowadz ID DLA POJAZDU ELEKTRYCZNEGO ALBO ID DLA POJAZDU SPALINOWEGO!
	ORA-06512: at "ST41K_DERDAS_ADRIAN.T_BI_w2_CCC_BOL_SER", line 19
	ORA-04088: error during execution of tXrigger 'ST41K_DERDAS_ADRIAN.T_BI_w2_CCC_BOL_SER'	
	*/
	-- OK!
		

		
---------------------------
PROMPT   table w2_PRODUCENCI
---------------------------	
create table w2_PRODUCENCI (
PRO_ID					number(8)		NOT NULL,
PRO_NAZWA_PRODUCENTA	varchar2(128)	NOT NULL,
PRO_ROK_ZAL				varchar2(20)	NOT NULL,
PRO_KRAJ				varchar2(30)	,
PRO_UWAGI 				varchar2(60)	
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

ALTER TABLE w2_PRODUCENCI NOLOGGING;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE w2_PRODUCENCI 
		ADD CONSTRAINT PK_w2_PRODUCENCI 
		PRIMARY KEY (PRO_ID) 
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;
	
	-- ----------------------#
	--  UNIQUE Keys;
	-- ----------------------#
	ALTER TABLE w2_PRODUCENCI
	ADD CONSTRAINT UQ1_w2_PRODUCENCI
		UNIQUE (PRO_NAZWA_PRODUCENTA)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;
		
	------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_w2_PRODUCENCI;
	
	CREATE SEQUENCE SEQ_w2_PRODUCENCI 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;
	
	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_BI_w2_PRODUCENCI
	BEFORE INSERT ON w2_PRODUCENCI
	FOR EACH ROW
	BEGIN
		IF :NEW.PRO_ID IS NULL THEN
			SELECT SEQ_w2_PRODUCENCI.NEXTVAL 
				INTO :NEW.PRO_ID FROM DUAL;
		END IF;
		--
	END;
	/

	------------------------
	-- DML w2_PRODUCENCI
	------------------------	
	insert into w2_PRODUCENCI(PRO_NAZWA_PRODUCENTA,PRO_ROK_ZAL,PRO_KRAJ,PRO_UWAGI)
	values ('MEYLE', '1977','NIEMCY','AKTYWNY'); 	

	insert into w2_PRODUCENCI(PRO_NAZWA_PRODUCENTA,PRO_ROK_ZAL,PRO_KRAJ,PRO_UWAGI)
	values ('MICHELIN', '1911','FRANCJA','ZAWIESZONA WSPOLPRACA'); 

		-- szybciej:
		select count(PRO_ID) from w2_PRODUCENCI;

		
	column PRO_ID HEADING 'ID' for 9999
	column PRO_NAZWA_PRODUCENTA HEADING 'NAZWA PRODUCENTA' for A20
	column PRO_ROK_ZAL HEADING 'ROK ZALOZENIA' for A16
	column PRO_KRAJ HEADING 'KRAJ' for A15
	column PRO_UWAGI HEADING 'UWAGI' for A30
		
	select * from w2_PRODUCENCI;
	
	
	/*
	   ID NAZWA PRODUCENTA     ROK ZALOZENIA    KRAJ            UWAGI
----- -------------------- ---------------- --------------- ----------------------
    1 MEYLE                1977             NIEMCY          AKTYWNY
    2 MICHELIN             1911             FRANCJA         ZAWIESZONA WSPOLPRACA
	
	*/

---------------------------
PROMPT   table w2_PODZESPOLY
---------------------------	
create table w2_PODZESPOLY (
POD_ID				number(8)		NOT NULL,
PRO_ID				number(8)		NOT NULL,
SER_ID				number(8)		NOT NULL,
POD_NAZWA			varchar2(20)	NOT NULL,
POD_PRZEZNACZENIE	varchar2(20)			
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

ALTER TABLE w2_PODZESPOLY NOLOGGING;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE w2_PODZESPOLY 
		ADD CONSTRAINT PK_w2_PODZESPOLY 
		PRIMARY KEY (POD_ID) 
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;

	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE w2_PODZESPOLY
		ADD CONSTRAINT FK1_w2_PODZESPOLY
		FOREIGN KEY(PRO_ID) 
		REFERENCES w2_PRODUCENCI(PRO_ID) ENABLE;
	
	------------------------
	--  FOREIGN Keys
	------------------------
	ALTER TABLE w2_PODZESPOLY
		ADD CONSTRAINT FK2_w2_PODZESPOLY
		FOREIGN KEY(SER_ID) 
		REFERENCES w2_SERWIS(SER_ID) ENABLE;
		
	------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_w2_PODZESPOLY;

	CREATE SEQUENCE SEQ_w2_PODZESPOLY 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;

	------------------------
	-- TRIGGER
	------------------------
	CREATE OR REPLACE TRIGGER T_BI_w2_PODZESPOLY
	BEFORE INSERT ON w2_PODZESPOLY
	FOR EACH ROW
	BEGIN
		IF :NEW.POD_ID IS NULL THEN
			SELECT SEQ_w2_PODZESPOLY.NEXTVAL 
				INTO :NEW.POD_ID FROM DUAL;
		END IF;
		--
	END;
	/		
	
	
---------------------------
PROMPT   table w2_BOLIDY
---------------------------	
create table w2_BOLIDY (
BOL_ID					number(8)		NOT NULL,
BOL_MARKA				varchar2(60)	NOT NULL,
BOL_TYP_PALIWA			varchar2(11)	default 'benzyna',
BOL_TYP_BATERII 		varchar2(80)	,
BOL_ZASIEG 				varchar2(80)	,
BOL_POJEMNOSC_SILNIKA	varchar2(80)	,
BOL_MOC_SILNIKA			varchar2(7)		,
)
PCTFREE 5
TABLESPACE STUDENT_DATA;

ALTER TABLE w2_BOLIDY NOLOGGING;

	------------------------
	-- PRIMARY KEY
	------------------------
	ALTER TABLE w2_BOLIDY 
		ADD CONSTRAINT PK_w2_BOLIDY 
		PRIMARY KEY (BOL_ID) 
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;

		
	-- ----------------------#
	--  UNIQUE Keys;
	-- ----------------------#
	ALTER TABLE w2_BOLIDY
	ADD CONSTRAINT UQ_w2_BOLIDY 
		UNIQUE (BOL_MARKA)
		USING INDEX
	PCTFREE 1
	TABLESPACE STUDENT_INDEX 
	NOLOGGING;

	------------------------
	-- SEQUENCE
	------------------------		
	drop sequence SEQ_w2_BOLIDY;

	CREATE SEQUENCE SEQ_w2_BOLIDY 
	INCREMENT BY 1 START WITH 1 MINVALUE 1;

	------------------------
	-- TRIGGER
	------------------------
	--
	-- UWAGA! Wyzwalacz realizuje funkcję "DISTINCT" dla osoby fizycznej i firmy z encji specjalizowanych!
	
	CREATE OR REPLACE TRIGGER T_BI_BOLIDY
	BEFORE INSERT ON BOLIDY
	FOR EACH ROW
	DECLARE
		EX_BOL1 EXCEPTION;
		PRAGMA EXCEPTION_INIT(EX_BOL1,-20001);
	BEGIN
		IF :NEW.BOL_ID IS NULL THEN
			SELECT SEQ_BOLIDY.NEXTVAL 
				INTO :NEW.BOL_ID FROM DUAL;
		END IF;
		--
		IF (:NEW.BOL_TYP_BATERII IS NOT NULL and :NEW.BOL_ZASIEG IS NOT NULL and :NEW.BOL_POJEMNOSC_SILNIKA IS NULL and :NEW.BOL_MOC_SILNIKA IS NULL) 
		or (:NEW.BOL_TYP_BATERII IS NULL and :NEW.BOL_ZASIEG IS NULL and :NEW.BOL_POJEMNOSC_SILNIKA IS NOT NULL and :NEW.BOL_MOC_SILNIKA IS NOT NULL) 
			
			THEN
				NULL;
		ELSE
			RAISE_APPLICATION_ERROR(-20001,'T_BI_BOLIDY: Err! Wprowadz TYP BATERII LUB ZASIEG DLA POJAZDU ELEKTRYYCZNEGO. WPROWADZ POJEMNOSC SILNIKA LUB MOC SILNIKA DLA POJAZDU SPALINOWEGO!');
		END IF;
		--
	END;
	/
	
	------------------------
	-- DML BOLIDY
	------------------------
PROMPT ELEKTRYCZNY
	
	insert into BOLIDY(BOL_MARKA,TYP_ID_TYP_BOL,BOL_TYP_PALIWA,BOL_TYP_BATERII,BOL_ZASIEG)
	values ('Alfa Romeo',1,'ELEKTRYK','LI-ION','320 KM');

	insert into BOLIDY(BOL_MARKA,TYP_ID_TYP_BOL,BOL_TYP_PALIWA,BOL_TYP_BATERII,BOL_ZASIEG)
	values ('AUDI',1,'ELEKTRYK','LI-ION','344 KM');

	column BOL_ID HEADING 'ID' for 999
	column BOL_MARKA HEADING 'MARKA' for A20
	column BOL_TYP_BATERII HEADING 'TYP BATERII' for A20
	column BOL_ZASIEG HEADING 'ZASIEG' for A20

			-- szybciej:
		select count(BOL_ID) from BOLIDY;
	
	select BOL_ID, BOL_MARKA, BOL_TYP_BATERII, BOL_ZASIEG
	from BOLIDY;
	/*
	  ID MARKA                TYP BATERII          ZASIEG
---- -------------------- -------------------- --------------------
   1 Alfa Romeo           LI-ION               320 KM
   2 AUDI                 LI-ION               344 KM
	*/
	
PROMPT SPALINOWY

	insert into BOLIDY(BOL_MARKA,TYP_ID_TYP_BOL,BOL_TYP_PALIWA,BOL_POJEMNOSC_SILNIKA)
	values ('FIAT',2,'E5','3989');
	
	
	select BOL_ID, BOL_MARKA, BOL_POJEMNOSC_SILNIKA;
	/*
  ID MARKA                BOL_POJEMNOSC_SILNIKA
---- -------------------- --------------------------------------------------------------------------------
   7 FIAT                 3989	
	*/
	
	select BOL_ID, BOL_MARKA from BOLIDY;

	/*
  ID MARKA
---- --------------------
   6 AUDI
   5 Alfa Romeo
   8 CITROEN
   7 FIAT
	*/
	
	
PROMPT BLEDNE DANE - TEST WYZWALACZA

	insert into BOLIDY(BOL_MARKA,BOL_TYP_PALIWA)
	values ('RENAULT','ELEKTRYCZNY');
	/*
	ERROR at line 1:
	ORA-20001: T_BI_BOLIDY: Err! Wprowadz TYP BATERII LUB ZASIEG DLA POJAZDU ELEKTRYYCZNEGO. WPROWADZ POJEMNOSC SILNIKA LUB MOC SILNIKA DLA POJAZDU SPALINOWEGO!
	ORA-06512: at "ST41K_DERDAS_ADRIAN.T_BI_BOLIDY", line 19
	ORA-04088: error during execution of tXrigger 'ST41K_DERDAS_ADRIAN.T_BI_BOLIDY'	
	*/
	-- OK!
	
-- ## -- ## -- ## -- ## -- ## -- ## --
-- ## -- ## -- ## -- ## -- ## -- ## --
-- ## -- ## -- ## -- ## -- ## -- ## --	
		
PROMPT ---------------------------
PROMPT   PODSUMOWANIA
PROMPT ---------------------------	

-- describe USER_TABLES
	column TABLE_NAME HEADING 'NAME' for A32
	column DROPPED HEADING 'NAME' for A32

PROMPT Lista utworzonych tabel:	

SELECT TABLE_NAME FROM USER_TABLES;


PROMPT------------------------
PROMPT TRIGGERs
PROMPT------------------------	
	
column TRIGGER_NAME HEADING 'TNAME' for A30
column TRIGGER_TYPE HEADING 'TYPE' for A20
column TRIGGERING_EVENT HEADING 'EVENT' for A20
column TABLE_NAME HEADING 'TABLE' for A30
	
select TRIGGER_NAME, TRIGGER_TYPE, TRIGGERING_EVENT, TABLE_NAME 
from USER_TRIGGERS;




-- ## -- ## -- ## -- ## -- ## -- ## --
SPOOL OFF